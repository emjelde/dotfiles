# Dotfiles

In Linux it is common for programs to use your home directory `~` for it's text
based configuration files. These files usually start with a dot character and
is why they are sometimes called dotfiles. Dotfiles usually remain hidden when
using commands like `ls` to list the directory contents and interestingly this
was likely an [unintended consequence](https://plus.google.com/+RobPikeTheHuman/posts/R58WgWwN9jp)
of trying to make `ls` not show `.` and `..` (links to the current and parent
directory).

This repository helps to manage my own dotfiles using a configuration
management framework called [salt](https://docs.saltstack.com/en/latest/) and
goes a bit further to also coordinate installation of the programs themselves.

The salt state system uses the SLS (**S**a**L**t **S**tate) files in this
repository as a representation of the state in which the system should be in.
Actions performed by salt's state modules ensure a well-known state and are
idempotent so applying the action multiple times results in no changes.

If starting from a clean repository the default goal for `make` will build a
Gentoo Linux virtual machine image and fully provision it up to the latest
state of repository. This image can serve as the next version of the system.
Additional goals will be provided to incrementally update the system as changes
are made to the repository.
