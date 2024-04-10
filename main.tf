resource "proxmox_virtual_environment_vm" "rke2_load_balancer" {
  count = 1

  name        = var.lb_vm_name
  description = "Nginx load balancer for RKE2 cluster, instantiated by OpenTofu"
  node_name   = "pve1"

  machine = "q35"
  bios    = "ovmf"
  on_boot = false

  initialization {
    ip_config {
      ipv4 {
        address = "${var.default_network}.40/24"
        gateway = "${var.default_network}.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = var.vm_password
      keys     = [file(var.local_ssh_public_key)]
    }
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format = "raw"
    type    = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    discard      = "on"
  }

  network_device {
    bridge = "vmbr0"
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 60
    ssd          = true
    discard      = "on"
    iothread     = true
  }

}

resource "proxmox_virtual_environment_vm" "rke2_server_ubuntu_vm" {
  count = 3

  name        = "${var.server_vm_prefix}-${count.index + 1}"
  description = "RKE2 server instantiated by OpenTofu"
  node_name   = "pve1"

  machine = "q35"
  bios    = "ovmf"
  on_boot = false

  initialization {
    ip_config {
      ipv4 {
        address = "${var.default_network}.${count.index + 41}/24"
        gateway = "${var.default_network}.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = var.vm_password
      keys     = [file(var.local_ssh_public_key)]
    }
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format = "raw"
    type    = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    discard      = "on"
  }

  network_device {
    bridge = "vmbr0"
  }

  cpu {
    cores = 4
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 16384
  }

  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 60
    ssd          = true
    discard      = "on"
    iothread     = true
  }

}

resource "proxmox_virtual_environment_vm" "rke2_agent_ubuntu_vm" {
  count = 1

  name        = "${var.agent_vm_prefix}-${count.index + 1}"
  description = "RKE2 agent instantiated by OpenTofu"
  node_name   = "pve1"

  machine = "q35"
  bios    = "ovmf"
  on_boot = false

  initialization {
    ip_config {
      ipv4 {
        address = "${var.default_network}.${count.index + 44}/24"
        gateway = "${var.default_network}.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = var.vm_password
      keys     = [file(var.local_ssh_public_key)]
    }
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format = "raw"
    type    = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    discard      = "on"
  }

  network_device {
    bridge = "vmbr0"
  }

  cpu {
      cores = 4
      type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 16384
  }

  disk {
      datastore_id = "local-lvm"
      file_format  = "raw"
      interface    = "scsi0"
      size         = 60
      ssd          = true
      discard      = "on"
      iothread     = true
  }

}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve1"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
