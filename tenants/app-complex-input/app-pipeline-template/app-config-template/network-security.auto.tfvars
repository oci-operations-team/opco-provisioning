# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Search and replace: 
#     - <application_name> with your application name
#     - <application_acronym> with your application acronym


### app network security
app_network_sec_config = {
  # Prod Network Security
  <application_name>_netsec_<application_acronym>prod01-vcn = {
    default_compartment_name = "cmp-prod-<application_acronym>-nw",
    vcn_name                 = "<application_acronym>prod01-vcn",
    default_defined_tags     = null,
    default_freeform_tags    = null,
    security_lists           = {},
    nsgs = {
      nsg_db_<application_name>_netsec_<application_acronym>prod01-vcn = {
        compartment_name = "cmp-prod-<application_acronym>-nw"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSGs"
            stateless   = false
            protocol    = "6"
            src         = "nsg_app_<application_name>_netsec_<application_acronym>prod01-vcn"
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
      nsg_app_<application_name>_netsec_<application_acronym>prod01-vcn = {
        compartment_name = "cmp-prod-<application_acronym>-nw"
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
  <application_name>_netsec_<application_acronym>stag01-vcn = {
    default_compartment_name = "cmp-prod-<application_acronym>-nw",
    vcn_name                 = "<application_acronym>stag01-vcn",
    default_defined_tags     = null,
    default_freeform_tags    = null,
    security_lists           = {},
    nsgs = {
      nsg_db_<application_name>_netsec_<application_acronym>stag01-vcn = {
        compartment_name = "cmp-stag-<application_acronym>-nw"
        defined_tags     = null,
        freeform_tags    = null,
        ingress_rules = [
          {
            description = "APP NSGs"
            stateless   = false
            protocol    = "6"
            src         = "nsg_app_<application_name>_netsec_<application_acronym>stag01-vcn"
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
      nsg_app_<application_name>_netsec_<application_acronym>stag01-vcn = {
        compartment_name = "cmp-stag-<application_acronym>-nw"
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









