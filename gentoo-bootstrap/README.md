# Gentoo Bootstrap

Create a Gentoo VirtualBox image provisioned using packer and salt states.

The default `make` command will perform a two stage build:

1st stage:

* Downloads the latest Gentoo minimal install iso
* Boots the iso in a new VirtualBox VM
* Performs the steps documented in the Gentoo installation handbook using **scripts**

2nd stage:

* Creates a new VirtualBox VM from output of the 1st stage
* Installs salt and copies states
* Runs salt in masterless mode calling state.highstate to apply states

If for some reason some state fails to apply you can resume salt after making
changes using `make resume` which renames the last packer output as
**output-virtualbox-ovf.last** and starts the next run.

To resume from the previous run use `make abort-resume` to remove the current
packer run moving **output-virtualbox-ovf.last** back to
**output-virtualbox-ovf**.
