# Proxmox OpenTofu configuration

1. Add the following `.tfvars`:
   1. `proxmox_user` - Proxmox username with realm (e.g. `user@pve`)
   2. `proxmox_server_ip` - Proxmox server IP address
   3. `proxmox_api_key_name` - Proxmox API key name
   4. `proxmox_api_key_secret` - Proxmox API key secret
2. Run `tofu plan`
3. Run `tofu apply`