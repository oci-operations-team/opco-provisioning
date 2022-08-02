# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  regions_map         = { for r in data.oci_identity_regions.these.regions : r.key => r.name } # All regions indexed by region key.
  regions_map_reverse = { for r in data.oci_identity_regions.these.regions : r.name => r.key }
  home_region_key     = data.oci_identity_tenancy.this.home_region_key # Home region key obtained from the tenancy data source
  region_key          = lower(local.regions_map_reverse[var.region])
  valid_service_gateway_cidrs = {
    all-services-in-oracle-services-network = "all-${local.region_key}-services-in-oracle-services-network",
    oci-objectstorage                       = "oci-${local.region_key}-objectstorage"
  }

  networking = {
    prod_networking = {
      default_network_compartment_name = var.networking.prod_networking.default_network_compartment_name
      service_label                    = var.networking.prod_networking.service_label
      service_gateway_cidr             = local.valid_service_gateway_cidrs[var.networking.prod_networking.service_gateway_cidr]
      drg_id                           = var.networking.prod_networking.drg_id
      vcns                             = var.networking.prod_networking.vcns
    }
    stag_networking = {
      default_network_compartment_name = var.networking.stag_networking.default_network_compartment_name
      service_label                    = var.networking.stag_networking.service_label
      service_gateway_cidr             = local.valid_service_gateway_cidrs[var.networking.stag_networking.service_gateway_cidr]
      drg_id                           = var.networking.stag_networking.drg_id
      vcns                             = var.networking.stag_networking.vcns
    }

  }
}

module "nexi-oci-app-provisioning" {

  source = "../../../"

  providers = {
    oci.home = oci.home
    oci      = oci
  }

  app_compartments_config = var.app_compartments_config

  networking = local.networking

  event_rules = var.event_rules

  app_network_sec_config = var.app_network_sec_config

  load_balancer_config = var.load_balancer_config

  instance_pool_config = var.instance_pool_config
}
