# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


output "network_security" {
  value = {
    security_lists = module.oci_security_policies.security_lists,
    nsgs           = module.oci_security_policies.nsgs
  }
}
