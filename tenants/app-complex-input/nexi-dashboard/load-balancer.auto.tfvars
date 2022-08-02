# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.





load_balancer_config = {

  # production lb
  prod_lb = {
    # the default attributes are used across the complex type for the default values of all the recurent compartment_id, defined_tags and freeform_tags attributes
    default_compartment_name = "opco-prod"
    default_defined_tags     = {}
    default_freeform_tags    = null


    lb_options = {
      display_name     = "opco_prod_lb"
      compartment_name = null
      shape            = "100Mbps"
      subnet_ids       = ["prod01-vcn.prod_public_lb"]
      private          = true
      nsg_ids          = null
      defined_tags     = null
      freeform_tags    = null

    }

    health_checks = {
      basic_http = {
        protocol            = "HTTP"
        interval_ms         = 1000
        port                = 80
        response_body_regex = ".*"
        retries             = 3
        return_code         = 200
        timeout_in_millis   = 3000
        url_path            = "/"
      }
    }

    backend_sets = {
      app1 = {
        policy             = "ROUND_ROBIN"
        health_check_name  = "basic_http"
        enable_persistency = false
        enable_ssl         = false

        cookie_name             = null
        disable_fallback        = null
        certificate_name        = null
        verify_depth            = null
        verify_peer_certificate = null

        backends = {
        }
      }
    }

    path_route_sets = {}


    rule_sets = {}

    listeners = {
      app1 = {
        default_backend_set_name = "app1"
        port                     = 80
        protocol                 = "HTTP"
        idle_timeout             = 180
        hostnames                = ["myapp.myorg.local"]
        path_route_set_name      = null
        rule_set_names           = null
        enable_ssl               = false
        certificate_name         = null
        verify_depth             = 5
        verify_peer_certificate  = true
      }
    }
  }

  # staging lb
  stag_lb = {
    # the default attributes are used across the complex type for the default values of all the recurent compartment_id, defined_tags and freeform_tags attributes
    default_compartment_name = "opco-stag"
    default_defined_tags     = {}
    default_freeform_tags    = null


    lb_options = {
      display_name     = "opco_stag_lb"
      compartment_name = null
      shape            = "100Mbps"
      subnet_ids       = ["stag01-vcn.stag_public_app"]
      private          = true
      nsg_ids          = null
      defined_tags     = null
      freeform_tags    = null

    }

    health_checks = {
      basic_http = {
        protocol            = "HTTP"
        interval_ms         = 1000
        port                = 80
        response_body_regex = ".*"
        retries             = 3
        return_code         = 200
        timeout_in_millis   = 3000
        url_path            = "/"
      }
    }

    backend_sets = {
      app1 = {
        policy             = "ROUND_ROBIN"
        health_check_name  = "basic_http"
        enable_persistency = false
        enable_ssl         = false

        cookie_name             = null
        disable_fallback        = null
        certificate_name        = null
        verify_depth            = null
        verify_peer_certificate = null

        backends = {
        }
      }
    }

    path_route_sets = {}


    rule_sets = {}

    listeners = {
      app1 = {
        default_backend_set_name = "app1"
        port                     = 80
        protocol                 = "HTTP"
        idle_timeout             = 180
        hostnames                = ["myapp.myorg.local"]
        path_route_set_name      = null
        rule_set_names           = null
        enable_ssl               = false
        certificate_name         = null
        verify_depth             = 5
        verify_peer_certificate  = true
      }
    }
  }
}