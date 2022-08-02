# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


variable "default_compartment_id" {
  type        = string
  description = "Default compartment OCID for event rules"
}

variable "event_rules" {
  description = "Event rules definitions"
  type = map(object({
    compartment_id : string,
    condition : string,
    display_name : string,
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
}

