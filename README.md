# Dotfiles

This repository helps to manage my own dotfiles and installation of the
packages using a configuration management framework called
[Salt](https://docs.saltstack.com/en/latest/).

The default goal for `make` creates and provisions a Gentoo machine image using
[Packer](https://packer.io).

## Getting Started

Install Packer on Gentoo which currently requires using testing keywords, you
can add these as shown below:

```sh
# Add testing keywords
mkdir --parents /etc/portage/package.accept_keywords/dev-util
echo =dev-util/packer-1.3.5 > /etc/portage/package.accept_keywords/dev-util/packer

# Install Packer
emerge dev-util/packer
```

I've tested most successfully with version 1.3.5, but Packer also provides
additional [install options](https://www.packer.io/intro/getting-started/install.html).

The configuration supports two kinds of Packer builders for VirtualBox and
QEMU:

```sh
# Install VirtualBox
emerge app-emulation/virtualbox

# or install QEMU
emerge app-emulation/qemu
```

The make command will use the VirtualBox builder by default. To use the QEMU
builder, make a copy of the `.env.example` file named `.env` in the same
directory and change `PACKER_BUILDER` to `qemu`:

```
PACKER_BUILDER=qemu
```

Now run the make command:

```sh
make
```

This will start a staged build process that will create a Gentoo base system
and then reboot into that Gentoo base system to install and configure the
packages and copy the dotfiles.

Here's an overview of the process:

Starting with the `gentoo/gentoo-autobuild-vars` script the latest Gentoo
minimal install ISO is downloaded and used as the boot medium for Packer.
Packer will provision the base system using `gentoo/gentoo.json` along with the
scripts under `gentoo`. This will create the VM image `build/gentoo-iso`.

Next, the salt state is prepared using `salt/salt-state-copy`. Packer then
boots the VM image `build/gentoo-iso` and using `salt/salt.json` Packer will
install and run Salt using the script `salt/01-install`. This will create the
VM image `build/gentoo-salt`.

Ending with a Gentoo machine built and configured with the latest packages.
