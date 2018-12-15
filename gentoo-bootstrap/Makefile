.PHONY: build clean install-amd64-minimal-latest.iso virtualbox virtualbox-salt

build: virtualbox-salt

clean:
	rm -f autobuild-variables.json
	rm -f vm-variables.json
	rm -rf autobuilds
	rm -rf output-virtualbox-iso
	rm -rf output-virtualbox-ovf
	rm -rf packer_cache
	rm -rf salt/salt

install-amd64-minimal-latest.iso:
	bash gen-autobuild-vars

virtualbox: install-amd64-minimal-latest.iso
	bash gen-vm-vars
	packer build -var-file=autobuild-variables.json -var-file=vm-variables.json virtualbox.json

virtualbox-salt: virtualbox
	bash copy-state
	packer build -var-file=vm-variables.json salt.json
