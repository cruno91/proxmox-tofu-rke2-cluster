resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count = 3

  name        = "example-vm-${count.index}"
  description = "Example VM created by OpenTofu"
  node_name   = "pve1"

  machine = "q35"
  bios    = "ovmf"
  on_boot = false

  initialization {
    ip_config {
      ipv4 {
        address = "10.0.3.${count.index + 20}/24"
        gateway = "10.0.3.1"
      }
    }

    user_account {
      username = "ubuntu"
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

  # network {
  #   model  = "virtio"
  #   bridge = "vmbr0"
  #   ip     = "10.0.3.${count.index + 10}/24"  # Change the IP range according to your network
  #   gw     = "10.0.3.1"  # Change this to your gateway IP
  # }

  cpu {
      cores = 2
      type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048 #16384  # 16 GB
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
