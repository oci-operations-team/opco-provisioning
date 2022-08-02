# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# Search and replace: 
#     - nd with your application acronym
#     - ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq with your OCI Stream OCID - Example: "ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq"



event_rules = {
  default_compartment_name = "opco-c-prod"
  event_rules = {
    # Production Resources Monitoring
    rule_prod_vcn_create = {
      actions = [{
        action_type = "OSS"
        description = "Write event data on Streaming Service"
        function_id = null
        is_enabled  = true
        stream_id   = "ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq"
        topic_id    = null
      }]
      compartment_name = "opco-c-prod"
      condition        = "{\"eventType\": \"com.oraclecloud.virtualnetwork.createvcn\"}"
      description      = "Test Event Rule - Prod VCN Create"
      is_enabled       = true
    }
    rule_prod_vcn_update = {
      actions = [{
        action_type = "OSS"
        description = "Write event data on Streaming Service"
        function_id = null
        is_enabled  = true
        stream_id   = "ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq"
        topic_id    = null
      }]
      compartment_name = "opco-c-prod"
      condition        = "{\"eventType\": \"com.oraclecloud.virtualnetwork.updatevcn\"}"
      description      = "Test Event Rule - Prod VCN Update"
      is_enabled       = true
    }

    # Staging Resources Monitoring
    rule_stag_vcn_create = {
      actions = [{
        action_type = "OSS"
        description = "Write event data on Streaming Service"
        function_id = null
        is_enabled  = true
        stream_id   = "ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq"
        topic_id    = null
      }]
      compartment_name = "opco-c-stag"
      condition        = "{\"eventType\": \"com.oraclecloud.virtualnetwork.createvcn\"}"
      description      = "Test Event Rule - Stag VCN Create"
      is_enabled       = true
    }
    rule_prod_vcn_update = {
      actions = [{
        action_type = "OSS"
        description = "Write event data on Streaming Service"
        function_id = null
        is_enabled  = true
        stream_id   = "ocid1.stream.oc1.uk-london-1.amaaaaaattkvkkiajfuvg7wv4fluyj7ye57duaah5axqmnxdkqg4xadbatrq"
        topic_id    = null
      }]
      compartment_name = "opco-c-stag"
      condition        = "{\"eventType\": \"com.oraclecloud.virtualnetwork.updatevcn\"}"
      description      = "Test Event Rule - Stag VCN Update"
      is_enabled       = true
    }
  }
}

