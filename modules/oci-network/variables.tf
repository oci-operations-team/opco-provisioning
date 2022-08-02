# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "networking" {
  description = "The VCNs."
  type = object({
    default_network_compartment_id = string,
    service_label                  = string,
    service_gateway_cidr           = string,
    drg_id                         = string,
    vcns = map(object({
      compartment_id    = string,
      cidr              = string,
      dns_label         = string,
      is_create_igw     = bool,
      is_attach_drg     = bool,
      block_nat_traffic = bool,
      defined_tags      = map(string),
      freeform_tags     = map(string),
      subnets = map(object({
        compartment_id  = string,
        name            = string,
        cidr            = string,
        dns_label       = string,
        private         = bool,
        dhcp_options_id = string,
        defined_tags    = map(string),
        freeform_tags   = map(string),
        security_lists = map(object({
          is_create      = bool,
          compartment_id = string,
          defined_tags   = map(string),
          freeform_tags  = map(string),
          ingress_rules = list(object({
            is_create    = bool,
            stateless    = bool,
            protocol     = string,
            description  = string,
            src          = string,
            src_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          })),
          egress_rules = list(object({
            is_create    = bool,
            stateless    = bool,
            protocol     = string,
            description  = string,
            dst          = string,
            dst_type     = string,
            src_port_min = number,
            src_port_max = number,
            dst_port_min = number,
            dst_port_max = number,
            icmp_type    = number,
            icmp_code    = number
          }))
        }))
      }))
    }))
  })
}
