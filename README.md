# Dotfiles

This repository helps to manage my own dotfiles and installation of the
packages using a configuration management framework called
[Salt](https://docs.saltstack.com/en/latest/topics/states/).

The default goal for `make` creates and provisions a Gentoo machine image using
[Packer](https://packer.io/intro/index.html).

## Getting Started

Install Packer on Gentoo which currently requires using accept keywords, you
can add these as shown below:

```sh
# Add accept keywords
mkdir --parents /etc/portage/package.accept_keywords/dev-util
echo =dev-util/packer-1.3.5 > /etc/portage/package.accept_keywords/dev-util/packer

# Install Packer
emerge dev-util/packer
```

Packer also provides additional
[install options](https://www.packer.io/intro/getting-started/install.html).

The configuration uses the Packer builder for QEMU:

```sh
# Install QEMU
emerge app-emulation/qemu
```

Now run the make command:

```sh
make
```

This starts a staged build process that will create a Gentoo base system and
then reboot into that Gentoo base system to install and configure the packages
and copy the dotfiles.

Here's an overview of the process:

Starting with the `gentoo/gentoo-autobuild-vars` script the latest Gentoo
minimal install ISO is downloaded and used as the boot medium for Packer.
Packer will provision the base system using `gentoo/gentoo.json` along with the
scripts under `gentoo`. This will create the VM image `build/gentoo-iso`.

Next, the salt state is prepared using `salt/salt-top`. Packer then
boots the VM image `build/gentoo-iso` and using `salt/salt.json` Packer will
install and run Salt using the script `salt/01-install`. This will create the
VM image `build/gentoo-salt`.
