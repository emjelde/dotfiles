# Dotfiles

This repository helps to capture my current workstation configuration and
automate the setup and update process using the
[Salt](https://docs.saltstack.com/en/latest/topics/states) configuration
management framework.

## Usage

Configuration changes that are managed by Salt can be applied by running
`./dotfiles apply`, this is usually the case for configuration referenced in
*sls* files. The other configuration not managed under Salt occurs in a
separate build process that is part of the initial Gentoo installation.

### Fresh install

The build command creates a Gentoo machine image using
[Packer](https://packer.io/intro).

Install Packer on Gentoo which currently requires accept keywords changes, you
can add these as shown below:

```sh
# The HCL2 template files being used requires a Packer version of at least 1.6.0.
# A version bump (https://bugs.gentoo.org/732174) has been requested but has yet
# to be pushed through since the ebuild has no current maintainer.
# Let's cheat a little for now...
cd /var/db/repos/gentoo/dev-util/packer
cp packer-1.4.5.ebuild packer-1.6.0.ebuild
ebuild packer-1.6.0.ebuild manifest
mkdir --parents /etc/portage/package.accept_keywords/dev-util
echo =dev-util/packer-1.6.0 > /etc/portage/package.accept_keywords/dev-util/packer

# Install Packer
emerge dev-util/packer
```

Packer also provides additional
[install options](https://www.packer.io/intro/getting-started/install).

The configuration uses the Packer builder for QEMU:

```sh
# Install QEMU
emerge app-emulation/qemu
```

Now run the build command:

```sh
./dotfiles build
```

This starts a staged build process that will create a Gentoo base system and
then reboot into that Gentoo base system to install and configure the packages
and copy the dotfiles.

Here's an overview of the process:

Starting with the `gentoo/gentoo-autobuild-vars` script the latest Gentoo
minimal install ISO is downloaded and used as the boot medium for Packer.
Packer will provision the base system using *gentoo/gentoo.pkr.hcl* along with the
scripts under *gentoo*. This will create the VM image *build/gentoo-iso*.

Next, the salt state is prepared using `salt/salt-top`. Packer then
boots the VM image *build/gentoo-iso* and using *salt/salt.pkr.hcl* Packer will
install and run Salt using the script `salt/salt-apply`. This will create the
VM image *build/gentoo-salt*.
