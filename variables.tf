variable "default_network" {
  description = "First 3 octets of your network"
  type        = string
  default     = "10.0.3"
}

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

variable "vm_password" {
  description = "Default password for VMs"
  type        = string
  default     = "ubuntu"
}

variable "lb_vm_name" {
  description = "Name for the load balancer VM"
  type        = string
  default     = "ex-lb"
}

variable "server_vm_prefix" {
  description = "Prefix for the server VMs"
  type        = string
  default     = "ex-srv"
}

variable "agent_vm_prefix" {
  description = "Prefix for the agent VMs"
  type        = string
  default     = "ex-agt"
}