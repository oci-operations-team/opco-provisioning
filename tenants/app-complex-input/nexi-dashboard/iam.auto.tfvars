# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Search and replace: 
#     - ocid1.compartment.oc1..aaaaaaaafvvtt7p5z67xyakfrcjgpbghwbldzxitdahhcopoa7qcdogqdj5q with your parent compartment OCID
#     - opco with your application name

# Compartments config Variable

app_compartments_config = {
  default_compartment_id = "ocid1.compartment.oc1..aaaaaaaawwhpzd5kxd7dcd56kiuuxeaa46icb44cnu7osq3mbclo2pnv3dpq"
  default_defined_tags   = {}
  default_freeform_tags  = null
  compartments = {

    # Production Compartments
    opco-prod = {
      description      = "Compartment holding production resources of opco application"
      compartment_id   = "ocid1.compartment.oc1..aaaaaaaawwhpzd5kxd7dcd56kiuuxeaa46icb44cnu7osq3mbclo2pnv3dpq"
      defined_tags     = null
      freeform_tags    = null
      enable_delete    = true
      sub_compartments = {}
    }

    # Staging Compartments
    opco-stag = {
      description      = "Compartment holding staging resources of opco application"
      compartment_id   = "ocid1.compartment.oc1..aaaaaaaawwhpzd5kxd7dcd56kiuuxeaa46icb44cnu7osq3mbclo2pnv3dpq"
      defined_tags     = null
      freeform_tags    = null
      enable_delete    = true
      sub_compartments = {}
    }
  }
}


