# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# Search and replace: 
#     - opco with your application name
#     - nd with your application acronym

networking = {

  # PROD VCNs
  prod_networking = {
    default_network_compartment_name = "opco-c-prod"
    service_label                    = "opco"
    service_gateway_cidr             = "all-services-in-oracle-services-network"
    drg_id                           = null
    vcns = {
      # Production VCN
      prod01-vcn = {
        compartment_name  = "opco-c-prod"
        cidr              = "10.0.0.0/22"
        dns_label         = "prod01"
        is_create_igw     = false
        is_attach_drg     = false
        block_nat_traffic = false
        defined_tags      = null
        freeform_tags     = null
        subnets = {
          prod_public_lb = {
            compartment_name = "opco-c-prod"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "10.0.0.0/24"
            dns_label        = "prdpublb"
            dhcp_options_id  = null
            security_lists   = {}
            private          = false
          }
          prod_private_app = {
            compartment_name = "opco-c-prod"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "10.0.1.0/24"
            dns_label        = "prdprvapp"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          prod_private_db = {
            compartment_name = "opco-c-prod"
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
    default_network_compartment_name = "opco-c-stag"
    service_label                    = "opco"
    service_gateway_cidr             = "all-services-in-oracle-services-network"
    drg_id                           = null
    vcns = {
      # STAG VCN
      stag01-vcn = {
        compartment_name  = "opco-c-stag"
        cidr              = "192.168.0.0/17"
        dns_label         = "stag01"
        is_create_igw     = false
        is_attach_drg     = false
        block_nat_traffic = false
        defined_tags      = null
        freeform_tags     = null
        subnets = {
          stag_public_app = {
            compartment_name = "opco-c-stag"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "192.168.0.0/24"
            dns_label        = "stagpubapp"
            dhcp_options_id  = null
            security_lists   = {}
            private          = false
          }
          stag_private_app = {
            compartment_name = "opco-c-stag"
            defined_tags     = null
            freeform_tags    = null
            cidr             = "192.168.1.0/24"
            dns_label        = "stagprvapp"
            dhcp_options_id  = null
            security_lists   = {}
            private          = true
          }
          stag_private_db = {
            compartment_name = "opco-c-stag"
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
