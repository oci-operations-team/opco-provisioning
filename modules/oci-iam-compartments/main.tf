# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


module "oci_iam_compartments" {

  source = "github.com/oracle-terraform-modules/terraform-oci-tdf-iam-compartments?ref=v0.2.6"

  providers = {
    oci.home = oci.home
  }

  compartments_config = var.compartments_config
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [module.oci_iam_compartments]

  create_duration = "60s"
}
