variable "proxmox_server_ip" {
  description = "IP address of the Proxmox server"
  type        = string
}

variable "proxmox_user" {
  description = "Username for Proxmox"
  type        = string
  default     = "root@pam"
}

variable "proxmox_api_key_name" {
  description = "Name of the API key for Proxmox"
  type        = string
}

variable "proxmox_api_key_secret" {
  description = "Secret of the API key for Proxmox"
  type        = string
}

variable "local_ssh_public_key" {
  description = "Local ssh key to authenticate with Proxmox"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "local_ssh_private_key" {
  description = "Local ssh key to authenticate with Proxmox"
  type        = string
  default     = "~/.ssh/id_rsa"
}