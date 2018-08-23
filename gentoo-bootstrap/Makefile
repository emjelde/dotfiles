.PHONY: build clean install-amd64-minimal-latest.iso virtualbox

build: virtualbox

clean:
	rm -f autobuild-variables.json
	rm -f vm-variables.json
	rm -rf autobuilds
	rm -rf output-virtualbox-iso
	rm -rf packer_cache

install-amd64-minimal-latest.iso:
	bash gen-autobuild-vars

virtualbox: install-amd64-minimal-latest.iso
	bash gen-vm-vars
	packer build -var-file=autobuild-variables.json -var-file=vm-variables.json virtualbox.json
