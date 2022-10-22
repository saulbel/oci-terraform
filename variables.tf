# Variables
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

# ssh pub key path
variable "ssh_public_key_file" {
  default = "/home/saul/.ssh/oci-ssh.pub"
}

variable "availability_domain" {
  default = "1"
}

variable "internet_gateway_enabled" {
  default = "true"
}

# We will change this to VM.Standard.E2.1.Micro once there is availability in Madrid
variable "instance_shape" {
  default = "VM.Standard2.1"
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "1"
}

# Centos 7 instance image
variable "instance_image_ocid" {
  type = map
  default = {
    eu-madrid-1 = "ocid1.image.oc1.eu-madrid-1.aaaaaaaa4bbvtjrjhllpwvhuvbu7ed7jfajco45xenlagbiyduuzxhvpq2sa"
  }
}
