# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Instance Pool
#########################


output "instance_pool" {
  description = "The instance pool and instance configuration details"
  value       = module.instance_pool_module.instance_pool

}





