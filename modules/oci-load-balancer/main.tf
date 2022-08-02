# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


module "instance_pool_module" {

  source = "github.com/oracle-terraform-modules/terraform-oci-tdf-lb?ref=v0.9.2"

  default_compartment_id = var.load_balancer_config.default_compartment_id

  lb_options = var.load_balancer_config.lb_options

  health_checks = var.load_balancer_config.health_checks

  backend_sets = var.load_balancer_config.backend_sets

  path_route_sets = var.load_balancer_config.path_route_sets

  rule_sets = var.load_balancer_config.rule_sets

  listeners = var.load_balancer_config.listeners
}
