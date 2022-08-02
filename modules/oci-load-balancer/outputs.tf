# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Load Balancer
#########################


output "load_balancer" {
  description = "The load balancer configuration"
  value = {
    lb              = module.instance_pool_module.lb
    lb_protocols    = module.instance_pool_module.lb_protocols
    lb_shapes       = module.instance_pool_module.lb_shapes
    certificates    = module.instance_pool_module.certificates
    backend_sets    = module.instance_pool_module.backend_sets
    backends        = module.instance_pool_module.backends
    path_route_sets = module.instance_pool_module.path_route_sets
    rule_sets       = module.instance_pool_module.rule_sets
    listeners       = module.instance_pool_module.listeners
    hostnames       = module.instance_pool_module.hostnames
  }
}





