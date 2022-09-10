variable "device_name" {
  type        = string
  description = "Name of block device for EBS"
  default     = "/dev/sda1"
}

variable "name" {
  type        = string
  description = "Name of launch instance (Required)"
}

variable "volume_size" {
  type        = number
  description = "size of EBS volume (GiB)"
  default     = 8
}

variable "image_id" {
  type        = string
  description = "ID of AMI image to be used for launch instance (Required)"
}

variable "instance_type" {
  type        = string
  description = "type of EC2 instance to be provisioned, e.g. t2.micro (Required)"
}

variable "key_name" {
  type        = string
  description = "Name of SSH keypair"
  default     = "SSH-keypair"
}
