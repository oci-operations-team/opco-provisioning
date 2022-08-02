# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


module "oci_events" {

  source = "git@cosmindev.github.com:fsana/oci_terraform_events.git"

  default_compartment_id = var.default_compartment_id
  event_rules            = var.event_rules
}



