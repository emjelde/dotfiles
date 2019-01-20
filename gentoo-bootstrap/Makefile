
.PHONY: build
build: virtualbox-salt

.PHONY: clean
clean:
	rm -f autobuild-variables.json
	rm -f vm-variables.json
	rm -rf autobuilds
	rm -rf output-virtualbox-iso
	rm -rf output-virtualbox-ovf
	rm -rf output-virtualbox-ovf.last
	rm -rf packer_cache
	rm -rf salt/salt

.PHONY: install-amd64-minimal-latest.iso
install-amd64-minimal-latest.iso:
	bash gen-autobuild-vars

.PHONY: virtualbox
virtualbox: install-amd64-minimal-latest.iso
	bash gen-vm-vars
	packer build -var-file=autobuild-variables.json -var-file=vm-variables.json virtualbox.json

.PHONY: virtualbox-salt
virtualbox-salt: virtualbox
	bash copy-state
	packer build -var-file=vm-variables.json salt.json

.PHONY: resume
resume:
	rm -rf output-virtualbox-ovf.last
	mv output-virtualbox-ovf output-virtualbox-ovf.last
	bash copy-state
	packer build -var-file=vm-variables.json resume.json

.PHONY: abort-resume
abort-resume:
	test -d output-virtualbox-ovf.last && \
	rm -rf output-virtualbox-ovf && \
	mv output-virtualbox-ovf.last output-virtualbox-ovf
