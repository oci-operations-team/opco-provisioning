# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# tenancy details
variable "tenancy_id" {}
variable "user_id" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Compartments Config Variable
variable "app_compartments_config" {
  type = object({
    default_compartment_id = string,
    default_defined_tags   = map(string),
    default_freeform_tags  = map(string),
    compartments = map(object({
      description    = string,
      compartment_id = string,
      defined_tags   = map(string),
      freeform_tags  = map(string),
      enable_delete  = bool,
      sub_compartments = map(object({
        description   = string,
        defined_tags  = map(string),
        freeform_tags = map(string),
        enable_delete = bool,
        sub_compartments = map(object({
          description   = string,
          defined_tags  = map(string),
          freeform_tags = map(string),
          enable_delete = bool,
          sub_compartments = map(object({
            description   = string,
            defined_tags  = map(string),
            freeform_tags = map(string),
            enable_delete = bool,
            sub_compartments = map(object({
              description   = string,
              defined_tags  = map(string),
              freeform_tags = map(string),
              enable_delete = bool,
              sub_compartments = map(object({
                description   = string,
                defined_tags  = map(string),
                freeform_tags = map(string),
                enable_delete = bool
              }))
            }))
          }))
        }))
      }))
    }))
  })
  description = "Parameters to provision zero, one or multiple compartments"
}

variable "networking" {
  description = "The VCNs."
  type = object({
    prod_networking = object({
      default_network_compartment_name = string,
      service_label                    = string,
      service_gateway_cidr             = string,
      drg_id                           = string,
      vcns = map(object({
        compartment_name  = string,
        cidr              = string,
        dns_label         = string,
        is_create_igw     = bool,
        is_attach_drg     = bool,
        block_nat_traffic = bool,
        defined_tags      = map(string),
        freeform_tags     = map(string),
        subnets = map(object({
          compartment_name = string,
          cidr             = string,
          dns_label        = string,
          private          = bool,
          dhcp_options_id  = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
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
    stag_networking = object({
      default_network_compartment_name = string,
      service_label                    = string,
      service_gateway_cidr             = string,
      drg_id                           = string,
      vcns = map(object({
        compartment_name  = string,
        cidr              = string,
        dns_label         = string,
        is_create_igw     = bool,
        is_attach_drg     = bool,
        block_nat_traffic = bool,
        defined_tags      = map(string),
        freeform_tags     = map(string),
        subnets = map(object({
          compartment_name = string,
          cidr             = string,
          dns_label        = string,
          private          = bool,
          dhcp_options_id  = string,
          defined_tags     = map(string),
          freeform_tags    = map(string),
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
  })
}

variable "app_network_sec_config" {
  type = map(object({
    default_compartment_name = string,
    vcn_name                 = string,
    default_defined_tags     = map(string),
    default_freeform_tags    = map(string),
    security_lists = map(object({
      compartment_name = string,
      defined_tags     = map(string),
      freeform_tags    = map(string),
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
      compartment_name = string,
      defined_tags     = map(string),
      freeform_tags    = map(string),
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
  }))
}

variable "event_rules" {
  description = "Event rules definitions"
  type = object({
    default_compartment_name : string,
    event_rules = map(object({
      compartment_name : string,
      condition : string,
      description : string,
      is_enabled : bool,
      actions : list(object({
        action_type : string,
        is_enabled : bool,
        description : string,
        function_id : string,
        stream_id : string,
        topic_id : string
      })),
    }))
  })
}
