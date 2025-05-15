resource "proxmox_vm_qemu" "proxmox_vm" {
  name         = "rocky9${var.short_name}${var.instance_num}"
  agent        = 1
  onboot       = true
  target_node  = var.node
  clone        = var.template
  cores        = var.cpu
  sockets      = "1"
  cpu          = "host"
  hotplug      = "network,disk,usb,cpu,memory"
  memory       = var.memory
  scsihw       = "virtio-scsi-pci"
  bootdisk     = "scsi0"
  numa         = true
  searchdomain = "lan"

  disk {
    type    = "scsi"
    size    = "${var.disk_size}G"
    storage = "local-lvm"
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no camfu@${self.default_ipv4_address} \"sudo hostnamectl set-hostname rocky9${var.short_name}${var.instance_num}.lan && sudo shutdown -r +1\""
  }
}