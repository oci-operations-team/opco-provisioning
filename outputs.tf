# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## OCI app Details
#########################

locals {

  network_security_output_map = {
    for k, v in module.oci-network-security : k =>
    v.network_security
  }

  nsgs_output_list_flat = flatten([
    for v in local.network_security_output_map : [for nsg in v.nsgs : nsg]
  ])

  nsgs_output_map_flat = {
    for nsg in local.nsgs_output_list_flat : nsg.display_name => nsg
  }

  security_lists_output_list_flat = flatten([
    for v in local.network_security_output_map : [for security_list in v.security_lists : security_list]
  ])

  security_lists_output_map_flat = {
    for security_list in local.security_lists_output_list_flat : security_list.display_name => security_list
  }



}

output "oci_app_details" {
  description = "The OCI VIP networking details"
  value = {
    compartments = module.oci-iam-compartments.compartments_config,
    #nsgs =  for nsg_v in local.nsgs_output_map_flat : nsg_v  if nsg_v.vcn_id == vcn_v.id 
    networking = {
      prod_networking = {
        for vcn_k, vcn_v in module.oci-prod-network.networking.vcns : vcn_k => merge(vcn_v, {
          nsgs = {
            for nsg_k, nsg_v in local.nsgs_output_map_flat : nsg_k => nsg_v if nsg_v.vcn_id == vcn_v.id
          },
          sec_rules = {
            for seclist_k, seclist_v in local.security_lists_output_map_flat : seclist_k => seclist_v if seclist_v.vcn_id == vcn_v.id
          }
        })
      },
      stag_networking = {
        for vcn_k, vcn_v in module.oci-stag-network.networking.vcns : vcn_k => merge(vcn_v, {
          nsgs = {
            for nsg_k, nsg_v in local.nsgs_output_map_flat : nsg_k => nsg_v if nsg_v.vcn_id == vcn_v.id
          },
          sec_rules = {
            for seclist_k, seclist_v in local.security_lists_output_map_flat : seclist_k => seclist_v if seclist_v.vcn_id == vcn_v.id
          }
        })
      },

      event_rules = module.oci-monitoring.event_rules
    }

    instance_pool = {
      prod_instrance_pool = module.oci-instance-pool-prod.instance_pool
      stag_instance_pool  = module.oci-instance-pool-stag.instance_pool
    }

    oci_lb = {
      lb_prod = module.oci-lb-prod.load_balancer
      lb_stag = module.oci-lb-stag.load_balancer
    }
  }
}

output "oci_app_details_flat" {
  description = "The networking details"
  value = {
    compartments = module.oci-iam-compartments.compartments_config_flat,
    networking = {
      prod_networking = module.oci-prod-network.networking_flat,
      stag_networking = module.oci-stag-network.networking_flat
    }
    network_security = {
      nsgs           = local.nsgs_output_map_flat,
      security_lists = local.security_lists_output_map_flat
    }
    event_rules = module.oci-monitoring.event_rules
    instance_pool = {
      prod_instrance_pool = module.oci-instance-pool-prod.instance_pool
      stag_instance_pool  = module.oci-instance-pool-stag.instance_pool
    }
    oci_lb = {
      lb_prod = module.oci-lb-prod.load_balancer
      lb_stag = module.oci-lb-stag.load_balancer
    }
  }
}




