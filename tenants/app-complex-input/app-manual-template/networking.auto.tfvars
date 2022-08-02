# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# Search and replace: 
#     - <application_name> with your application name
#     - <application_acronym> with your application acronym

networking = {

  # PROD VCNs
  prod_networking = {
    default_network_compartment_name = "cmp-prod-<application_acronym>-nw"
    service_label                    = "<application_name>"
    service_gateway_cidr             = "all-services-in-oracle-services-network"
    drg_id                           = null
    vcns = {
      # Production VCN
      <application_acronym>prod01-vcn = {
        compartment_name  = "cmp-prod-<application_acronym>-nw"
        cidr              = "10.0.0.0/22"
        dns_label         = "<application_acronym>prod01"
        is_create_igw     = false
        is_attach_drg     = false
        block_nat_traffic = false
        defined_tags      = null
        freeform_tags     = null
        subnets = {
          prod_private_infra = {
            compartment_name = "cmp-prod-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "10.0.0.0/24"
            dns_label        = "prdprvinfr"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          prod_private_app = {
            compartment_name = "cmp-prod-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "10.0.1.0/24"
            dns_label        = "prdprvapp"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          prod_private_db = {
            compartment_name = "cmp-prod-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "10.0.2.0/24"
            dns_label        = "prdprvdb"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
        }
      }
    }
  }

    # STAG VCNs
  stag_networking = {
    default_network_compartment_name = "cmp-stag-<application_acronym>-nw"
    service_label                    = "<application_name>"
    service_gateway_cidr             = "all-services-in-oracle-services-network"
    drg_id                           = null
    vcns = {
      # STAG VCN
      <application_acronym>stag01-vcn = {
        compartment_name  = "cmp-stag-<application_acronym>-nw"
        cidr              = "192.168.0.0/17"
        dns_label         = "<application_acronym>stag01"
        is_create_igw     = false
        is_attach_drg     = false
        block_nat_traffic = false
        defined_tags      = null
        freeform_tags     = null
        subnets = {
          stag_private_infra = {
            compartment_name = "cmp-stag-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "192.168.0.0/24"
            dns_label        = "stagprvinfr"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          stag_private_app = {
            compartment_name = "cmp-stag-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "192.168.1.0/24"
            dns_label        = "stagprvapp"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          stag_private_db = {
            compartment_name = "cmp-stag-<application_acronym>-nw"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "192.168.2.0/24"
            dns_label        = "stagprvdb"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
        }
      }
    }
  }
}
