# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


terraform {
  required_providers {
    oci = {
      #source = "hashicorp/oci"
      #version               = "~> 4.64.0"
      configuration_aliases = [oci.home, oci]
    }
  }
}

