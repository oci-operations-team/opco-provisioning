# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


instance_pool_config = {
  instance_pool_prod = null
  instance_pool_stag = null
}



/*
instance_pool_config = {
  instance_pool_prod = {
    default_compartment_id = null
    default_defined_tags   = null
    default_freeform_tags  = null

    instance_pool = null
  }

  instance_pool_stag = {
    default_compartment_id = null
    default_defined_tags   = null
    default_freeform_tags  = null

    instance_pool = null
  }
}
*/

/*

instance_pool_config = {
  # production instance pool
  instance_pool_prod = {
    default_compartment_name = "opco-s-prod"
    default_defined_tags     = {}
    default_freeform_tags    = null

    instance_pool = {
      compartment_name = "opco-s-prod"
      size             = 2
      defined_tags     = {}
      freeform_tags    = null
      display_name     = "opco_prod_inst_pool"

      # required
      placements_configurations = {
        # required
        ad = "NoEK:UK-LONDON-1-AD-1"
        # optional
        fd = null
        # required
        primary_subnet_name = "prod01-vcn.prod_private_app"
        #optional
        secondary_vnic_subnets = {}
      }

      # optional
      #load_balancers = {}


      load_balancers = {
        opco_test_lb = {
          load_balancer_name = "opco_prod_lb"
          backend_set_name   = "app1"
          port               = "80"
          vnic_selection     = "PrimaryVnic"
        }
      }



      instance_configuration = {
        # required
        compartment_name = "opco-s-prod"

        #optional 
        defined_tags  = {}
        freeform_tags = null
        display_name  = "opco_prod_inst_config"

        # optional - Default = NONE; Values = ["NONE, INSTANCE"]
        source = "NONE"
        # Required when source=INSTANCE
        instance_id = null
        # required 
        instance_details = {

          # required - The type of instance details. Supported instanceType is compute
          instance_type = "compute"

          # optional
          block_volumes = {}

          # optional
          launch_details = {
            # optional
            ad = "NoEK:UK-LONDON-1-AD-1"
            # optional
            fd = null
            # optional
            capacity_reservation_id = null
            # optional
            compartment_name = "opco-s-prod"
            # optional
            dedicated_vm_host_id = null
            # optional
            defined_tags = {}
            # optional
            freeform_tags = null
            # optional
            display_name = "opco_prod_launch_details"
            # optional
            extended_metadata = null
            # optional
            ipxe_script = null
            # optional
            is_pv_encryption_in_transit_enabled = false
            # optional value in [NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM]
            launch_mode = "NATIVE"
            # optional
            ssh_public_key_path = "/Users/cotudor/my_ssh_keys/cos_key.pub"
            # optional - value in [LIVE_MIGRATE, REBOOT] - default = LIVE_MIGRATE
            preferred_maintenance_action = "LIVE_MIGRATE"
            # optional
            shape = "VM.Standard2.1"
            # optional
            agent_config = null
            # optional
            availability_config = null

            create_vnic_details = {
              # optional
              assign_private_dns_record = false
              # optional
              assign_public_ip = false
              # optional
              defined_tags = {}
              # optional
              freeform_tags = null
              # optional
              display_name = "opco_prod_instpool_vnic1"
              # optional
              hostname_label = "opcoprodinstpoll",
              # optional 
              nsg_ids = null
              # optional
              private_ip = null
              # optional
              skip_source_dest_check = true
              # optional
              subnet_name = "prod01-vcn.prod_private_app"
            }

            # optional
            instance_options = null

            # optional
            launch_options = null
            # optional
            platform_config = null

            # optional
            preemptible_instance_config = null

            # optional
            shape_config = null

            # optionals
            source_details = {

              # required - value in [bootvolume, image]
              source_type = "image"
              # optional - Applicable when source_type=bootVolume
              boot_volume_id = null
              # optional - Applicable when source_type=image
              boot_volume_size_in_gbs = 50
              # optional -  Applicable when source_type=image
              image_id = "ocid1.image.oc1.uk-london-1.aaaaaaaaummuogirswnepvbgzob5pdv73oegkkfzoweb7ioo2vodqei5wtea"
            }


          }

          # optional
          secondary_vnics = {}
        }

      }

      # optional
      auto_scaling_configuration = {
        auto_scaling_resources = {
          # resource type
          type = "instancePool"
        }
        # required
        compartment_name = "opco-s-prod"

        #Optional
        cool_down_in_seconds = 300
        defined_tags         = null
        display_name         = "opco_prod_auto_scaling"
        freeform_tags        = null
        is_enabled           = true

        # required
        policies = {
          # Required value in [scheduled, threshold]
          policy_type = "threshold"
          # optional 
          capacity = {
            #Optional
            initial = 2
            max     = 5
            min     = 2
          }
          # optional 
          display_name = "opco_prod_auto_scaling_policy"
          # required when policy_type=scheduled
          execution_schedule = null
          # optional
          is_enabled = true
          # required when policy_type=scheduled
          resource_action = null
          # required 
          rules = {
            opco_prod_rule_1_scale_out = {

              # required 
              action = {

                # required 
                type = "CHANGE_COUNT_BY"
                # required
                value = 1
              }

              # Required 
              display_name = "opco_prod_rule_1_scale_out"

              # Required when policy_type=threshold
              metric = {

                # Required when policy_type=threshold
                metric_type = "CPU_UTILIZATION"
                # Required when policy_type=threshold
                threshold = {

                  # Required when policy_type=threshold
                  operator = "GT"
                  # Required when policy_type=threshold
                  value = "70"
                }
              }
            }

            opco_prod_rule_1_scale_in = {
              # required 
              action = {

                # required 
                type = "CHANGE_COUNT_BY"
                # required 
                value = -1
              }

              # Required 
              display_name = "opco_prod_rule_1_scale_out"

              # Required when policy_type=threshold
              metric = {

                # Required when policy_type=threshold
                metric_type = "CPU_UTILIZATION"
                # Required when policy_type=threshold
                threshold = {

                  # Required when policy_type=threshold
                  operator = "LT"
                  # Required when policy_type=threshold
                  value = "50"
                }
              }
            }
          }
        }
      }
    }
  }

  # staging instance pool
  instance_pool_stag = {
    default_compartment_name = "opco-s-stag"
    default_defined_tags     = {}
    default_freeform_tags    = null

    instance_pool = {
      compartment_name = "opco-s-stag"
      size             = 2
      defined_tags     = {}
      freeform_tags    = null
      display_name     = "opco_stag_inst_pool"

      # required
      placements_configurations = {
        # required
        ad = "NoEK:UK-LONDON-1-AD-1"
        # optional
        fd = null
        # required
        primary_subnet_name = "stag01-vcn.stag_private_app"
        #optional
        secondary_vnic_subnets = {}
      }

      # optional
      #load_balancers = {}


      load_balancers = {
        opco_test_lb = {
          load_balancer_name = "opco_stag_lb"
          backend_set_name   = "app1"
          port               = "80"
          vnic_selection     = "PrimaryVnic"
        }
      }



      instance_configuration = {
        # required
        compartment_name = "opco-s-stag"

        #optional 
        defined_tags  = {}
        freeform_tags = null
        display_name  = "opco_stag_inst_config"

        # optional - Default = NONE; Values = ["NONE, INSTANCE"]
        source = "NONE"
        # Required when source=INSTANCE
        instance_id = null
        # required 
        instance_details = {

          # required - The type of instance details. Supported instanceType is compute
          instance_type = "compute"

          # optional
          block_volumes = {}

          # optional
          launch_details = {
            # optional
            ad = "NoEK:UK-LONDON-1-AD-1"
            # optional
            fd = null
            # optional
            capacity_reservation_id = null
            # optional
            compartment_name = "opco-s-stag"
            # optional
            dedicated_vm_host_id = null
            # optional
            defined_tags = {}
            # optional
            freeform_tags = null
            # optional
            display_name = "opco_stag_launch_details"
            # optional
            extended_metadata = null
            # optional
            ipxe_script = null
            # optional
            is_pv_encryption_in_transit_enabled = false
            # optional value in [NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM]
            launch_mode = "NATIVE"
            # optional
            ssh_public_key_path = "/Users/cotudor/my_ssh_keys/cos_key.pub"
            # optional - value in [LIVE_MIGRATE, REBOOT] - default = LIVE_MIGRATE
            preferred_maintenance_action = "LIVE_MIGRATE"
            # optional
            shape = "VM.Standard2.1"
            # optional
            agent_config = null
            # optional
            availability_config = null

            create_vnic_details = {
              # optional
              assign_private_dns_record = false
              # optional
              assign_public_ip = false
              # optional
              defined_tags = {}
              # optional
              freeform_tags = null
              # optional
              display_name = "opco_stag_instpool_vnic1"
              # optional
              hostname_label = "opcostaginstpoll",
              # optional 
              nsg_ids = null
              # optional
              private_ip = null
              # optional
              skip_source_dest_check = true
              # optional
              subnet_name = "stag01-vcn.stag_private_app"
            }

            # optional
            instance_options = null

            # optional
            launch_options = null
            # optional
            platform_config = null

            # optional
            preemptible_instance_config = null

            # optional
            shape_config = null

            # optionals
            source_details = {

              # required - value in [bootvolume, image]
              source_type = "image"
              # optional - Applicable when source_type=bootVolume
              boot_volume_id = null
              # optional - Applicable when source_type=image
              boot_volume_size_in_gbs = 50
              # optional -  Applicable when source_type=image
              image_id = "ocid1.image.oc1.uk-london-1.aaaaaaaaummuogirswnepvbgzob5pdv73oegkkfzoweb7ioo2vodqei5wtea"
            }


          }

          # optional
          secondary_vnics = {}
        }

      }

      # optional
      auto_scaling_configuration = {
        auto_scaling_resources = {
          # resource type
          type = "instancePool"
        }
        # required
        compartment_name = "opco-s-stag"

        #Optional
        cool_down_in_seconds = 300
        defined_tags         = null
        display_name         = "opco_stag_auto_scaling"
        freeform_tags        = null
        is_enabled           = true

        # required
        policies = {
          # Required value in [scheduled, threshold]
          policy_type = "threshold"
          # optional 
          capacity = {
            #Optional
            initial = 2
            max     = 5
            min     = 2
          }
          # optional 
          display_name = "opco_stag_auto_scaling_policy"
          # required when policy_type=scheduled
          execution_schedule = null
          # optional
          is_enabled = true
          # required when policy_type=scheduled
          resource_action = null
          # required 
          rules = {
            opco_stag_rule_1_scale_out = {

              # required 
              action = {

                # required 
                type = "CHANGE_COUNT_BY"
                # required
                value = 1
              }

              # Required 
              display_name = "opco_stag_rule_1_scale_out"

              # Required when policy_type=threshold
              metric = {

                # Required when policy_type=threshold
                metric_type = "CPU_UTILIZATION"
                # Required when policy_type=threshold
                threshold = {

                  # Required when policy_type=threshold
                  operator = "GT"
                  # Required when policy_type=threshold
                  value = "70"
                }
              }
            }

            opco_stag_rule_1_scale_in = {
              # required 
              action = {

                # required 
                type = "CHANGE_COUNT_BY"
                # required 
                value = -1
              }

              # Required 
              display_name = "opco_stag_rule_1_scale_out"

              # Required when policy_type=threshold
              metric = {

                # Required when policy_type=threshold
                metric_type = "CPU_UTILIZATION"
                # Required when policy_type=threshold
                threshold = {

                  # Required when policy_type=threshold
                  operator = "LT"
                  # Required when policy_type=threshold
                  value = "50"
                }
              }
            }
          }
        }
      }
    }
  }
}

*/
