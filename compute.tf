resource "oci_core_instance" "terraform-instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  shape               = "${var.instance_shape}"
  count               = "${var.num_instances}"
  display_name        = "terraform-instance"
  
  create_vnic_details {
    subnet_id         = "${oci_core_subnet.terraform_subnet.id}"
    assign_public_ip  = true
    private_ip        = "10.0.0.2"
    display_name      = "primary-vnic"
  }
  
  source_details {
    source_type             = "image"
    source_id               = "${"${var.instance_image_ocid[var.region]}"}"
    boot_volume_size_in_gbs = "50"
  }

  preserve_boot_volume = false
  
  metadata = {
    ssh_authorized_keys = "${file(var.ssh_public_key_file)}"
  }
}
