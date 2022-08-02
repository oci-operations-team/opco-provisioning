# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Search and replace: 
#     - opco with your application name
#     - nd with your application acronym


### app network security
app_network_sec_config = {
  # Prod Network Security
  opco_netsec_prod01-vcn = {
    default_compartment_name = "opco-prod",
    vcn_name                 = "prod01-vcn",
    default_defined_tags     = null,
    default_freeform_tags    = null,
    security_lists           = {},
    nsgs = {
      nsg_db_opco_netsec_prod01-vcn = {
        compartment_name = "opco-prod"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSGs"
            stateless   = false
            protocol    = "6"
            src         = "nsg_app_opco_netsec_prod01-vcn"
            src_type    = "NSG_NAME"
            src_port    = null
            dst_port = {
              min = "1521"
              max = "1521"
            }
            icmp_code = null
            icmp_type = null
          }
        ]
        egress_rules = [
          {
            description = "egress to anywhere"
            stateless   = false
            protocol    = "all"
            dst         = "0.0.0.0/0"
            dst_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port    = null
            icmp_code   = null
            icmp_type   = null
          }
        ]
      },
      nsg_app_opco_netsec_prod01-vcn = {
        compartment_name = "opco-prod"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSG"
            stateless   = false
            protocol    = "6"
            src         = "0.0.0.0/0"
            src_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port = {
              min = "443"
              max = "443"
            }
            icmp_code = null
            icmp_type = null
          }
        ]
        egress_rules = [
          {
            description = "egress to anywhere"
            stateless   = false
            protocol    = "all"
            dst         = "0.0.0.0/0"
            dst_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port    = null
            icmp_code   = null
            icmp_type   = null
          }
        ]
      }
    }
  }

  # Stag Network Security
  opco_netsec_stag01-vcn = {
    default_compartment_name = "opco-stag",
    vcn_name                 = "stag01-vcn",
    default_defined_tags     = null,
    default_freeform_tags    = null,
    security_lists           = {},
    nsgs = {
      nsg_db_opco_netsec_stag01-vcn = {
        compartment_name = "opco-stag"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSGs"
            stateless   = false
            protocol    = "6"
            src         = "nsg_app_opco_netsec_stag01-vcn"
            src_type    = "NSG_NAME"
            src_port    = null
            dst_port = {
              min = "1521"
              max = "1521"
            }
            icmp_code = null
            icmp_type = null
          }
        ]
        egress_rules = [
          {
            description = "egress to anywhere"
            stateless   = false
            protocol    = "all"
            dst         = "0.0.0.0/0"
            dst_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port    = null
            icmp_code   = null
            icmp_type   = null
          }
        ]
      },
      nsg_app_opco_netsec_stag01-vcn = {
        compartment_name = "opco-stag"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSG"
            stateless   = false
            protocol    = "6"
            src         = "0.0.0.0/0"
            src_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port = {
              min = "443"
              max = "443"
            }
            icmp_code = null
            icmp_type = null
          }
        ]
        egress_rules = [
          {
            description = "egress to anywhere"
            stateless   = false
            protocol    = "all"
            dst         = "0.0.0.0/0"
            dst_type    = "CIDR_BLOCK"
            src_port    = null
            dst_port    = null
            icmp_code   = null
            icmp_type   = null
          }
        ]
      }
    }
  }
}









