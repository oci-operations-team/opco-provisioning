# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


variable "network_security" {
  type = object({
    default_compartment_id = string,
    vcn_id                 = string,
    default_defined_tags   = map(string),
    default_freeform_tags  = map(string),
    security_lists = map(object({
      compartment_id = string,
      defined_tags   = map(string),
      freeform_tags  = map(string),
      ingress_rules = list(object({
        stateless = bool,
        protocol  = string,
        src       = string,
        src_type  = string,
        src_port = object({
          min = number,
          max = number
        }),
        dst_port = object({
          min = number,
          max = number
        }),
        icmp_type = number,
        icmp_code = number
      })),
      egress_rules = list(object({
        stateless = bool,
        protocol  = string,
        dst       = string,
        dst_type  = string,
        src_port = object({
          min = number,
          max = number
        }),
        dst_port = object({
          min = number,
          max = number
        }),
        icmp_type = number,
        icmp_code = number
      }))
    })),
    nsgs = map(object({
      compartment_id = string,
      defined_tags   = map(string),
      freeform_tags  = map(string),
      ingress_rules = list(object({
        description = string,
        stateless   = bool,
        protocol    = string,
        src         = string,
        # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
        src_type = string,
        src_port = object({
          min = number,
          max = number
        }),
        dst_port = object({
          min = number,
          max = number
        }),
        icmp_type = number,
        icmp_code = number
      })),
      egress_rules = list(object({
        description = string,
        stateless   = bool,
        protocol    = string,
        dst         = string,
        # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
        dst_type = string,
        src_port = object({
          min = number,
          max = number
        }),
        dst_port = object({
          min = number,
          max = number
        }),
        icmp_type = number,
        icmp_code = number
      }))
    }))
  })
}