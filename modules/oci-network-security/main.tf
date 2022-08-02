# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "oci_security_policies" {
  source = "github.com/oracle-terraform-modules/terraform-oci-tdf-network-security?ref=v0.9.7"

  default_compartment_id = var.network_security.default_compartment_id
  default_freeform_tags  = var.network_security.default_freeform_tags
  vcn_id                 = var.network_security.vcn_id

  security_lists = var.network_security.security_lists
  nsgs           = var.network_security.nsgs
}