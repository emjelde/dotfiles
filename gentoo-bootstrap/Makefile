# When Packer is invoked it sometimes calls out to checkpoint.hashicorp.com to
# look for new versions of Packer. Disable this for security and privacy
# reasons.
export CHECKPOINT_DISABLE=1

# Location of the packer cache
export PACKER_CACHE_DIR=build/packer_cache

# Location of the packer log
export PACKER_LOG=1
export PACKER_LOG_PATH=build/build.log

.PHONY: build
build: gentoo-salt

.PHONY: clean
clean:
	rm -rf build

.PHONY: install-amd64-minimal-latest.iso
install-amd64-minimal-latest.iso:
	bash gentoo/gentoo-autobuild-vars

.PHONY: gentoo
gentoo: install-amd64-minimal-latest.iso
	bash gentoo/gentoo-vm-vars
	packer build -var-file=build/autobuild-variables.json -var-file=build/vm-variables.json gentoo/gentoo.json

.PHONY: gentoo-salt
gentoo-salt: gentoo
	bash salt/salt-state-copy
	packer build -var-file=build/vm-variables.json salt/salt.json

.PHONY: resume
resume:
	rm -rf build/gentoo-salt.last
	mv build/gentoo-salt build/gentoo-salt.last
	bash salt/salt-state-copy
	packer build -var-file=build/vm-variables.json salt/resume.json

.PHONY: abort-resume
abort-resume:
	test -d build/gentoo-salt.last && \
	rm -rf build/gentoo-salt && \
	mv build/gentoo-salt.last build/gentoo-salt
