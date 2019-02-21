BUILD = build
SHELL = /bin/bash

# When Packer is invoked it sometimes calls out to checkpoint.hashicorp.com to
# look for new versions of Packer. Disable this for security and privacy
# reasons.
export CHECKPOINT_DISABLE=1

# Location of the packer cache
export PACKER_CACHE_DIR=$(BUILD)/packer_cache

# Enable packer log
export PACKER_LOG=1

.ONESHELL:

.PHONY: all
all: $(BUILD)/gentoo-salt

.PHONY: clean
clean:
	rm -rf $(BUILD)

autobuild_vars = $(BUILD)/autobuild-variables.json

$(autobuild_vars):
	./gentoo/gentoo-autobuild-vars

vm_vars = $(BUILD)/vm-variables.json

$(vm_vars):
	./gentoo/gentoo-vm-vars

$(BUILD)/salt:
	./salt/salt-state-copy

$(BUILD)/gentoo-iso: $(autobuild_vars) $(vm_vars)
	export PACKER_LOG_PATH=$(BUILD)/gentoo-iso.log
	packer build -var-file=$(autobuild_vars) -var-file=$(vm_vars) gentoo/gentoo.json

$(BUILD)/gentoo-salt: $(BUILD)/gentoo-iso $(BUILD)/salt
	export PACKER_LOG_PATH=$(BUILD)/gentoo-salt.log
	packer build -var-file=$(vm_vars) salt/salt.json

.PHONY: resume
resume:
	test -d $(BUILD)/gentoo-salt && \
	rm -rf $(BUILD)/gentoo-salt.last && \
	mv $(BUILD)/gentoo-salt $(BUILD)/gentoo-salt.last && \
	./salt/salt-state-copy && \
	packer build -var-file=$(BUILD)/vm-variables.json salt/salt-resume.json

.PHONY: abort-resume
abort-resume:
	test -d $(BUILD)/gentoo-salt.last && \
	rm -rf $(BUILD)/gentoo-salt && \
	mv $(BUILD)/gentoo-salt.last $(BUILD)/gentoo-salt