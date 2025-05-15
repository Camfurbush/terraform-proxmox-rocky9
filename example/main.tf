terraform {
  backend "s3" {}
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
    vault = {
      source = "hashicorp/vault"
    }
  }
}

provider "vault" {
}
data "vault_generic_secret" "ssh_pass" {
  path = "internal/generic"
}

provider "proxmox" {
  pm_api_url      = "https://proxmox.lan:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = data.vault_generic_secret.ssh_pass.data["password"]
  pm_tls_insecure = "true"
}

module "rocky9example1" {
  source = "git::ssh://git@github.com/camfurbush/terraform-proxmox-rocky9.git"

  short_name   = "example"
  instance_num = "1"
  disk_size    = 200
  memory       = 16384
  cpu          = 4
}
