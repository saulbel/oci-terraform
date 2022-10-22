data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}

data "oci_core_images" "centos_image" {
  compartment_id           = "${var.tenancy_ocid}"
  operating_system         = "Centos"
  operating_system_version = "7"
}
