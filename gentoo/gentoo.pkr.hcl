# Gentoo Linux (iso)

variable "build" {
  type = string
}

variable "cpuflags" {
  type = string
}

variable "cpus" {
  type = number
}

variable "gentoo_keyring" {
  type = string
}

variable "gentoo_mirrors" {
  type = string
}

variable "gentoo_release_mirror" {
  type = string
}

variable "gentoo_rsync_mirror" {
  type = string
}

variable "headless" {
  type = bool
  default = true
}

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
}

variable "memory" {
  type = number
}

variable "root_volume_group" {
  type = string
  default = "roflpc"
}

variable "ssh_username" {
  type = string
  default = "root"
}

variable "ssh_password" {
  type = string
  default = "correcthorsebatterystaple"
}

variable "stage3" {
  type = string
}

source "qemu" "gentoo-iso" {
  vm_name = "gentoo-iso"
  output_directory = "${var.build}/gentoo-iso"
  cpus = var.cpus
  memory = var.memory
  disk_interface = "ide"
  net_device = "e1000"
  headless = var.headless
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  boot_command = [
    "gentoo-nofb nokeymap dosshd passwd=${var.ssh_password}<enter>"
  ]
  shutdown_command = "shutdown -h now"
}

build {
  description = "Gentoo Linux (iso)"

  sources = [
    "qemu.gentoo-iso"
  ]

  provisioner "file" {
    source = "kernel"
    destination = "/tmp"
  }

  provisioner "file" {
    source = var.gentoo_keyring
    destination = "/tmp/gentoo-release.asc"
  }

  provisioner "file" {
    source = "portage"
    destination = "/tmp"
  }

  provisioner "shell" {
    environment_vars = [
      "BOOT_DEVICE=/dev/sda1",
      "CPUS=${var.cpus}",
      "CPU_FLAGS_X86=${var.cpuflags}",
      "GENTOO_KEYRING=/tmp/gentoo-release.asc",
      "GENTOO_MIRRORS=${var.gentoo_mirrors}",
      "LUKS_DEVICE=/dev/sda2",
      "RELEASE_MIRROR=${var.gentoo_release_mirror}",
      "ROOT_DEVICE=/dev/${var.root_volume_group}/root",
      "ROOT_VOLUME_GROUP=${var.root_volume_group}",
      "RSYNC_MIRROR=${var.gentoo_rsync_mirror}",
      "SOURCE=/tmp",
      "STAGE3=${var.stage3}",
      "SWAP_DEVICE=/dev/${var.root_volume_group}/swap"
    ]

    scripts = [
      "gentoo/01-partition",
      "gentoo/02-stage3",
      "gentoo/03-mounts",
      "gentoo/04-resolvconf",
      "gentoo/05-portage",
      "gentoo/06-timezone",
      "gentoo/07-fstab",
      "gentoo/08-kernel",
      "gentoo/09-network",
      "gentoo/10-system"
    ]
  }
}
