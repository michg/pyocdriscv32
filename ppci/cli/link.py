""" Linker.

Use the linker to combine several object files and a memory layout
to produce another resulting object file with images.
"""

import argparse
import sys
from .base import base_parser, out_parser, LogSetup
from .. import api


parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=__doc__,
    parents=[base_parser, out_parser],
)
parser.add_argument(
    "obj", type=argparse.FileType("r"), nargs="+", help="the object to link"
)
parser.add_argument(
    "--library",
    help="Add library to use when searching for symbols.",
    type=argparse.FileType("r"),
    action="append",
    default=[],
    metavar="library-filename",
)
parser.add_argument(
    "--layout",
    "-L",
    help="memory layout",
    default=None,
    type=argparse.FileType("r"),
    metavar="layout-file",
)
parser.add_argument(
    "-g", help="retain debug information", action="store_true", default=False
)
parser.add_argument(
    "--relocatable",
    "-r",
    help="Generate relocatable output",
    action="store_true",
    default=False,
)
parser.add_argument(
    "--entry",
    "-e",
    help="Use entry as the starting symbol of execution of the program.",
    default=None,
)


def link(args=None):
    """ Run linker from command line """
    args = parser.parse_args(args)
    relocatable = args.relocatable
    with LogSetup(args):
        obj = api.link(
            args.obj,
            layout=args.layout,
            debug=args.g,
            partial_link=relocatable,
            entry=args.entry,
        )
        if relocatable:
            with open(args.output, "w") as output:
                obj.save(output)
        else:
            create_platform_executable(obj, args.output)


def create_platform_executable(obj, output_filename):
    """ Produce platform binary by spitting out exe/elf file. """
    if sys.platform == "linux":
        executable_filename = output_filename
        api.objcopy(obj, None, "elf", executable_filename)
    else:
        # TODO: create windows exe.
        # raise NotImplementedError('Executable output not support for platform: {}'.format(sys.platform))
        executable_filename = output_filename
        api.objcopy(obj, None, "elf", executable_filename)


if __name__ == "__main__":
    link()
