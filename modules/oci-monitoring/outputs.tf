# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Event Rules
#########################

output "event_rules" {
  value = module.oci_events.event_rules
}