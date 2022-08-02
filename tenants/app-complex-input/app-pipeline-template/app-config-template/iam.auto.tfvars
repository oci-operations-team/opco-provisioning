# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Search and replace: 
#     - <parent_compartment_ocid> with your parent compartment OCID
#     - <application_name> with your application name
#     - <application_acronym> with your application acronym

# Compartments config Variable

app_compartments_config = {
  default_compartment_id = "<parent_compartment_ocid>"
  default_defined_tags   = {}
  default_freeform_tags  = null
  compartments = {

    # Production Compartments
    cmp-prod-<application_acronym> = {
      description    = "Compartment holding production resources of <application_name> application"
      compartment_id = "<parent_compartment_ocid>"
      defined_tags   = null
      freeform_tags  = null
      enable_delete  = true
      sub_compartments = {
        cmp-prod-<application_acronym>-nw = {
          description   = "Compartment holding production network resources of <application_name> application"
          defined_tags  = null
          freeform_tags = null
          enable_delete = true
          sub_compartments = {}
        }
        cmp-prod-<application_acronym>-db = {
          description   = "Compartment holding production database resources of <application_name> application"
          defined_tags  = null
          freeform_tags = null
          enable_delete = true
          sub_compartments = {}
        }
      }
    }

    #Staging Compartments
    cmp-stag-<application_acronym> = {
      description    = "Compartment holding staging resources of <application_name> application"
      compartment_id = "<parent_compartment_ocid>"
      defined_tags   = null
      freeform_tags  = null
      enable_delete  = true
      sub_compartments = {
        cmp-stag-<application_acronym>-nw = {
          description   = "Compartment holding staging network resources of <application_name> application"
          defined_tags  = null
          freeform_tags = null
          enable_delete = true
          sub_compartments = {}
        }
        cmp-stag-<application_acronym>-db = {
          description   = "Compartment holding staging database resources of <application_name> application"
          defined_tags  = null
          freeform_tags = null
          enable_delete = true
          sub_compartments = {}
        }
      }
    }
  }
}


