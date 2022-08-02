# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Compartments Config Variable
variable "compartments_config" {
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

