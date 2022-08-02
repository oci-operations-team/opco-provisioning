# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Compartments
#########################

output "compartments_config" {
  description = "compartments:"
  value = {
    compartments = module.oci_iam_compartments.compartments_config
  }.compartments
}

output "compartments_config_flat" {
  description = "compartments:"
  value = {
    compartments = module.oci_iam_compartments.compartments_config_flat
  }.compartments
}