# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.



variable "load_balancer_config" {
  type = object({
    # the default attributes are used across the complex type for the default values of all the recurent compartment_id, defined_tags and freeform_tags attributes
    default_compartment_id = string,
    default_defined_tags   = map(string),
    default_freeform_tags  = map(string),


    lb_options = object({
      display_name   = string
      compartment_id = string
      shape          = string
      subnet_ids     = list(string)
      private        = bool
      nsg_ids        = list(string)
      defined_tags   = map(string)
      freeform_tags  = map(string)

    })

    health_checks = map(object({
      protocol            = string
      interval_ms         = number
      port                = number
      response_body_regex = string
      retries             = number
      return_code         = number
      timeout_in_millis   = number
      url_path            = string
      }
    ))

    backend_sets = map(object({
      policy                  = string
      health_check_name       = string
      enable_persistency      = bool
      enable_ssl              = bool
      cookie_name             = string
      disable_fallback        = bool
      certificate_name        = string
      verify_depth            = string
      verify_peer_certificate = bool
      backends = map(object({
        ip      = string
        port    = number
        backup  = string
        drain   = string
        offline = string
        weight  = number
      }))
    }))

    path_route_sets = map(list(object({
      backend_set_name = string
      path             = string
      match_type       = string
    })))

    rule_sets = map(list(object({
      action = string
      header = string
      prefix = string
      suffix = string
      value  = string
    })))

    listeners = map(object({
      default_backend_set_name = string
      port                     = number
      protocol                 = string
      idle_timeout             = number
      hostnames                = list(string)
      path_route_set_name      = string
      rule_set_names           = list(string)
      enable_ssl               = bool
      certificate_name         = string
      verify_depth             = number
      verify_peer_certificate  = bool
    }))

  })
}