# VCN
resource "oci_core_vcn" "terraform_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = "${var.compartment_ocid}"  
  dns_label      = "vcn"
  display_name   = "terraform-vcn"
}

# Security rules
resource "oci_core_security_list" "terraform_sl" {
  compartment_id  = "${var.compartment_ocid}"
  vcn_id          = "${oci_core_vcn.terraform_vcn.id}"

  egress_security_rules {
      protocol    = "all"
      destination = "0.0.0.0/0"
  }
  
  ingress_security_rules {
      protocol    = "6"
      source      = "0.0.0.0/0"
      description = "SSH allow"
      tcp_options {
	      max = 22
	      min = 22
      }     
  }

  ingress_security_rules {
      protocol    = "6"
      source      = "0.0.0.0/0"
      description = "Http allow"
      tcp_options {
        max = 80    
        min = 80    
      }     
  }

  ingress_security_rules {
      protocol    = "6"
      source      = "0.0.0.0/0"
      description = "Https allow"
      tcp_options {
        max = 443    
        min = 443   
      }     
  }
  display_name = "terraform-sl"
}

# Internet gateway
resource "oci_core_internet_gateway" "terraform_ig" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.terraform_vcn.id}"  
  enabled        = "${var.internet_gateway_enabled}"
  display_name   = "terraform-gt"
}

# Route table
resource "oci_core_route_table" "terraform_rt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.terraform_vcn.id}"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.terraform_ig.id}"
  }  
  display_name = "terraform-rt"
}

# Public subnet
resource "oci_core_subnet" "terraform_subnet" {
  cidr_block          = "10.0.0.0/30"
  compartment_id      = "${var.compartment_ocid}"
  security_list_ids   = ["${oci_core_security_list.terraform_sl.id}"]
  vcn_id              = "${oci_core_vcn.terraform_vcn.id}" 
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1], "name")}"
  dhcp_options_id     = "${oci_core_vcn.terraform_vcn.default_dhcp_options_id}"
  route_table_id      = "${oci_core_route_table.terraform_rt.id}"
  display_name        = "terraform-st"
  dns_label           = "terraformsubnet"
}