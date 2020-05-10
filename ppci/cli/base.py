""" Base parser definitions shared between most cli utilities. """

import argparse
import logging
import os
import cgitb
import platform
import sys
from .. import __version__
from ..arch.target_list import target_names, create_arch
from ..build.tasks import TaskError
from ..common import logformat, CompilerError
from ..utils.reporting import HtmlReportGenerator, DummyReportGenerator
from ..utils.reporting import TextReportGenerator


version_text = "ppci {} on {} {} on {}".format(
    __version__,
    platform.python_implementation(),
    platform.python_version(),
    platform.platform(),
)


def log_level(s):
    """ Converts a string to a valid logging level """
    numeric_level = getattr(logging, s.upper(), None)
    if not isinstance(numeric_level, int):
        raise ValueError("Invalid log level: {}".format(s))
    return numeric_level


class OnceAction(argparse.Action):
    """ Use this action to enforce that an option is only given once """

    def __call__(self, parser, namespace, values, option_string=None):
        if getattr(namespace, self.dest, None) is not None:
            raise argparse.ArgumentError(self, "Cannot give multiple")
        setattr(namespace, self.dest, values)


base_parser = argparse.ArgumentParser(add_help=False)
base_parser.add_argument(
    "--log",
    help="Log level (info,debug,warn)",
    metavar="log-level",
    type=log_level,
    default="info",
)
base_parser.add_argument(
    "--report",
    metavar="report-file",
    action=OnceAction,
    help="Specify a file to write the compile report to",
    type=argparse.FileType("w"),
)
base_parser.add_argument(
    "--html-report",
    metavar="html-report-file",
    action=OnceAction,
    help="Write html report file",
    type=argparse.FileType("w"),
)
base_parser.add_argument(
    "--text-report",
    metavar="text-report-file",
    action=OnceAction,
    help="Write a report into a text file",
    type=argparse.FileType("w"),
)
base_parser.add_argument(
    "--verbose",
    "-v",
    action="count",
    default=0,
    help="Increase verbosity of the output",
)
base_parser.add_argument(
    "--version",
    "-V",
    action="version",
    version=version_text,
    help="Display version and exit",
)
base_parser.add_argument(
    "--pudb",
    dest="drop_into_pudb",
    action="store_true",
    help="Drop into post mortem pudb session on crash",
)

march_parser = argparse.ArgumentParser(add_help=False)
march_parser.add_argument(
    "--machine",
    "-m",
    help="target architecture",
    choices=target_names,
    action=OnceAction,
)
march_parser.add_argument(
    "--mtune",
    help="architecture option",
    default=[],
    metavar="option",
    action="append",
)


def get_arch_from_args(args):
    """ Determine the intended machine target and select the proper options """
    if args.machine:
        machine = args.machine
    else:
        machine = platform.machine()
    options = tuple(args.mtune)
    return create_arch(machine, options=options)


out_parser = argparse.ArgumentParser(add_help=False)
out_parser.add_argument(
    "--output",
    "-o",
    help="output file",
    metavar="output-file",
    default="f.out",
)


class ColoredFormatter(logging.Formatter):
    """ Custom formatter that makes vt100 coloring to log messages """

    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
    # Before changing colors, consider that they must be legible on
    # (at least) both white-on-black and black-on-white terminal themes.
    colors = {"WARNING": MAGENTA, "ERROR": RED}

    def format(self, record):
        reset_seq = "\033[0m"
        color_seq = "\033[1;%dm"
        levelname = record.levelname
        msg = super().format(record)
        if levelname in self.colors:
            color = color_seq % (30 + self.colors[levelname])
            msg = color + msg + reset_seq
        return msg


class LogSetup:
    """ Context manager that attaches logging to a snippet """

    def __init__(self, args):
        self.args = args
        self.console_handler = None
        self.file_handler = None
        self.logger = logging.getLogger()
        cgitb.enable(format="text")

        if args.drop_into_pudb:

            def hook(typ, value, tb):
                import pudb

                pudb.post_mortem(tb)

            sys.excepthook = hook

    def __enter__(self):
        self.logger.setLevel(logging.DEBUG)
        self.console_handler = logging.StreamHandler()
        self.console_handler.setFormatter(ColoredFormatter(logformat))
        self.console_handler.setLevel(self.args.log)
        self.logger.addHandler(self.console_handler)

        if self.args.verbose > 0:
            self.console_handler.setLevel(logging.DEBUG)

        if self.args.report:
            self.file_handler = logging.StreamHandler(self.args.report)
            self.logger.addHandler(self.file_handler)

        if self.args.html_report:
            self.reporter = HtmlReportGenerator(self.args.html_report)
            self.reporter.header()
        elif self.args.text_report:
            self.reporter = TextReportGenerator(self.args.text_report)
            self.reporter.header()
        else:
            self.reporter = DummyReportGenerator()
        self.logger.debug("Reporting to %s", self.reporter)
        self.logger.debug("Loggers attached")
        self.logger.info(version_text)
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if exc_type:
            self.reporter.dump_exception((exc_type, exc_value, traceback))

        # Check if a task error was raised:
        if isinstance(exc_value, TaskError):
            self.logger.error(str(exc_value.msg))
            err = True
        else:
            err = False

        if isinstance(exc_value, CompilerError):
            self.logger.error(str(exc_value.msg))
            self.logger.error(str(exc_value.loc))
            exc_value.print()

            # Report the error:
            self.reporter.dump_compiler_error(exc_value)
            err = True

        if isinstance(exc_value, FileNotFoundError):
            self.logger.error("File not found %s", exc_value)
            err = True

        if exc_value is not None:
            # Exception happened, close file and remove
            if hasattr(self.args, "output"):
                if os.path.exists(self.args.output):
                    filename = self.args.output
                    os.remove(filename)

        self.logger.debug("Removing loggers")
        if self.args.report:
            self.logger.removeHandler(self.file_handler)
            self.args.report.close()

        self.reporter.footer()

        if self.args.html_report:
            self.args.html_report.close()

        if self.args.text_report:
            self.args.text_report.close()

        self.logger.removeHandler(self.console_handler)

        # exit code when error:
        if err:
            sys.exit(1)
