# Makefile for dotfiles

# Location of Packer output including files needed during the build
export BUILD = build

# When Packer is invoked it sometimes calls out to checkpoint.hashicorp.com to
# look for new versions of Packer. Disable this for security and privacy
# reasons.
export CHECKPOINT_DISABLE = 1

# Location of the Packer cache
export PACKER_CACHE_DIR = $(BUILD)/packer_cache

# Enable Packer log
export PACKER_LOG = 1

SHELL = /bin/bash

.ONESHELL:

.PHONY: all
all: $(BUILD)/gentoo-salt

.PHONY: clean
clean:
	rm -rf $(BUILD)

define source-env =
	if [ -f .env ]; then
		set -o allexport
		source .env
		set +o allexport
	fi
endef

autobuild_vars = $(BUILD)/autobuild-variables.json
vm_vars = $(BUILD)/vm-variables.json

$(BUILD)/gentoo-iso:
	$(source-env) && \
	gentoo/gentoo-autobuild-vars && \
	gentoo/gentoo-vm-vars && \
	export PACKER_LOG_PATH=$(BUILD)/gentoo-iso.log && \
	packer build -var-file=$(autobuild_vars) -var-file=$(vm_vars) gentoo/gentoo.json

$(BUILD)/gentoo-salt: $(BUILD)/gentoo-iso
	$(source-env) && \
	gentoo/gentoo-vm-vars && \
	salt/salt-top && \
	salt/salt-pillar && \
	export PACKER_LOG_PATH=$(BUILD)/gentoo-salt.log && \
	packer build -var-file=$(vm_vars) salt/salt.json
