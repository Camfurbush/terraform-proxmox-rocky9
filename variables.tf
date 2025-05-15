# Administrative

variable "short_name" {
  type        = string
  description = "The short name to use for the server."
  default     = "test"
}

variable "instance_num" {
  type        = string
  description = "The instance number of the node"
  default     = "1"
}

variable "node" {
  type        = string
  description = "The node to deploy the VM to"
  default     = "proxmox"
}

# Machine Resources

variable "memory" {
  type        = number
  description = "The amount of RAM (in MB)"
  default     = 4096
}

variable "cpu" {
  type        = number
  description = "The number of CPUs"
  default     = 1
}

variable "disk_size" {
  type        = number
  description = "The disk size for the servers (in MB)"
  default     = 30
}

variable "template" {
  type        = string
  description = "The template name to clone from."
  default     = "Template-ROCKY9"
}
