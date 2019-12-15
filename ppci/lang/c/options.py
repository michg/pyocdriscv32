from argparse import ArgumentParser


class COptions:
    """ A collection of settings regarding the C language """

    def __init__(self):
        self.settings = {}
        self.include_directories = []
        self.macros = []
        self.undefine_macros = []

        # Initialize defaults:
        self.disable("trigraphs")
        self.set("std", "c99")
        self.disable("verbose")
        self.disable("freestanding")

        # TODO: temporal default paths:
        # self.add_include_path('/usr/include')
        # self.add_include_path(
        #    '/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/include/')

    def add_include_path(self, path):
        """ Add a path to the list of include paths """
        self.include_directories.append(path)

    def add_include_paths(self, paths):
        """ Add all the given include paths """
        for path in paths:
            self.add_include_path(path)

    def enable(self, setting):
        self.settings[setting] = True

    def disable(self, setting):
        self.settings[setting] = False

    def set(self, setting, value):
        self.settings[setting] = value

    def __getitem__(self, index):
        return self.settings[index]

    def process_args(self, args):
        """ Given a set of parsed arguments, apply those """
        self.set("trigraphs", args.trigraphs)
        self.set("std", args.std)
        self.set("freestanding", args.freestanding)

        for path in args.I:
            self.add_include_path(path)

        for macro in args.define:
            if "=" in macro:
                name, value = macro.split("=", 1)
            else:
                name, value = macro, "1"
            self.add_define(name, value)

        for name in args.undefine:
            self.undefine_macros.append(name)

        self.set("verbose", args.super_verbose)

    @classmethod
    def from_args(cls, args):
        """ Create a new options object from parsed arguments. """
        o = cls()
        o.process_args(args)
        return o

    def add_define(self, name, value):
        self.macros.append((name, value))


# Construct an argument parser for the various C options:
coptions_parser = ArgumentParser(add_help=False)
coptions_parser.add_argument(
    "-I",
    action="append",
    default=[],
    metavar="dir",
    help="Add directory to the include path",
)
coptions_parser.add_argument(
    "-D",
    "--define",
    action="append",
    default=[],
    metavar="macro",
    help="Define a macro",
)
coptions_parser.add_argument(
    "-U",
    "--undefine",
    action="append",
    default=[],
    metavar="macro",
    help="Undefine a macro",
)
coptions_parser.add_argument(
    "--include",
    action="append",
    default=[],
    metavar="file",
    help="Include a file before all other sources",
)
coptions_parser.add_argument(
    "--trigraphs",
    action="store_true",
    default=False,
    help="Enable trigraph processing",
)
coptions_parser.add_argument(
    "--std",
    choices=("c89", "c99"),
    default="c99",
    help="The C version you want to use",
)
coptions_parser.add_argument(
    "--super-verbose",
    action="store_true",
    default=False,
    help="Add extra verbose output during C compilation",
)
coptions_parser.add_argument(
    "--freestanding",
    action="store_true",
    default=False,
    help="Compile in free standing mode.",
)
