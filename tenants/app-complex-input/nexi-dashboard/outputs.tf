# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Compartments
#########################



output "app_config" {
  description = "app_config:"
  value = {
    config      = module.nexi-oci-app-provisioning.oci_app_details,
    home_region = [for i in data.oci_identity_region_subscriptions.this.region_subscriptions : i.region_name if i.is_home_region == true][0]
  }
}




output "app_config_flat" {
  description = "app_config_flat:"
  value = {
    config      = module.nexi-oci-app-provisioning.oci_app_details_flat,
    home_region = [for i in data.oci_identity_region_subscriptions.this.region_subscriptions : i.region_name if i.is_home_region == true][0]
  }
}









