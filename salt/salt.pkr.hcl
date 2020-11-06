# Gentoo Linux (salt)

variable "build" {
  type = string
}

variable "cpus" {
  type = number
}

variable "headless" {
  type = bool
  default = true
}

variable "memory" {
  type = number
}

variable "ssh_username" {
  type = string
  default = "root"
}

variable "ssh_password" {
  type = string
  default = "correcthorsebatterystaple"
}

source "qemu" "gentoo-salt" {
  vm_name = "gentoo-salt"
  output_directory = "${var.build}/gentoo-salt"
  disk_image = true
  cpus = var.cpus
  memory = var.memory
  disk_interface = "ide"
  net_device = "e1000"
  qemuargs = [
     ["-bios", "/usr/share/edk2-ovmf/OVMF_CODE.fd"]
  ]
  headless = var.headless
  iso_url = "${var.build}/gentoo-iso/gentoo-iso"
  iso_checksum = "none"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  shutdown_command = "shutdown -h now"
}

build {
  description = "Gentoo Linux (salt)"

  sources = [
    "qemu.gentoo-salt"
  ]

  provisioner "shell-local" {
    environment_vars = [
      "PILLAR_DIR=${var.build}/pillar",
      "SALT_DIR=${var.build}/salt",
      "SALT_KEYS=${var.build}/salt-keys"
    ]

    inline = [
      "salt/salt-top --force",
      "salt/salt-pillar"
    ]
  }

  provisioner "shell" {
    inline = [
      "mkdir /etc/salt",
      "mkdir /srv"
    ]
  }

  provisioner "file" {
    source = "salt"
    destination = "/tmp"
  }

  provisioner "file" {
    generated = true
    source = "${var.build}/pillar"
    destination = "/srv"
  }

  provisioner "file" {
    generated = true
    source = "${var.build}/salt"
    destination = "/srv"
  }

  provisioner "file" {
    generated = true
    source = "${var.build}/salt-keys"
    destination = "/etc/salt/gpgkeys"
  }

  provisioner "shell" {
    environment_vars = [
      "SOURCE=/tmp"
    ]

    inline = [
     "cd /tmp",
     "salt/salt-apply"
    ]
  }
}
