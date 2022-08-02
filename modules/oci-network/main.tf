# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

// source = "../../../cis-oci-landing-zone.issue84-mon_tags-locals/modules/network/vcn-basic"



module "opco_vcns" {

  source = "github.com/oracle-quickstart/oci-cis-landingzone-quickstart?ref=v2.3.1.0/modules/network/vcn-basic"

  compartment_id = var.networking.default_network_compartment_id

  service_label = var.networking.service_label

  service_gateway_cidr = var.networking.service_gateway_cidr

  drg_id = var.networking.drg_id

  vcns = var.networking.vcns
}