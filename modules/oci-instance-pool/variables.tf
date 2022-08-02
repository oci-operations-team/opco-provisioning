# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.



variable "instance_pool_config" {
  type = object({
    # the default attributes are used across the complex type for the default values of all the recurent compartment_id, defined_tags and freeform_tags attributes
    default_compartment_id = string,
    default_defined_tags   = map(string),
    default_freeform_tags  = map(string),


    instance_pool = object({
      # required
      compartment_id = string,

      # required
      size = number,

      # optional
      defined_tags  = map(string),
      freeform_tags = map(string),
      display_name  = string,

      # required
      placements_configurations = object({
        # required
        ad = string,
        # optional
        fd = list(string),
        # required
        primary_subnet_id = string,

        # optional
        secondary_vnic_subnets = map(object({
          subnet_id    = string,
          display_name = string,
        }))
      })

      # optional
      load_balancers = map(object({
        # required
        load_balancer_id = string,
        backend_set_name = string,
        port             = string,
        vnic_selection   = string
      }))

      instance_configuration = object({

        # required
        compartment_id = string,

        #optional 
        defined_tags  = map(string),
        freeform_tags = map(string),
        display_name  = string,


        # optional - Default = NONE; Values = ["NONE, INSTANCE"]
        source = string,
        # Required when source=INSTANCE
        instance_id = string,

        # required 
        instance_details = object({

          # required - The type of instance details. Supported instanceType is compute
          instance_type = string,

          # optional
          block_volumes = map(object({
            # optional 
            attach_details = object({
              # required; values = [iscsi, paravirtualized]
              type = string,
              # required - applicable when type = isci - default = false
              use_chap = bool

              #optional
              device                              = string,
              display_name                        = string,
              is_pv_encryption_in_transit_enabled = bool,
              is_read_only                        = bool,
              is_shareable                        = bool,
            })

            # optional - creates a new block volume
            create_details = object({
              ad               = string,
              backup_policy_id = string,
              compartment_id   = string,
              defined_tags     = map(string),
              freeform_tags    = map(string),
              display_name     = map(string),
              kms_key_id       = string,
              size_in_gbs      = number,
              # optional - value in [0(lower cost), 10(balanced option), 20(high performance), 30(ultra high performance)]
              vpus_per_gb = number,
              volume_id   = string,

              # optional
              source_details = object({

                # Required - value in [volume, volumeBackup]
                type = string,
                id   = string
              })
            })
          }))

          # optional  
          launch_details = object({
            # optional
            ad = string,
            # optional
            fd = string,
            # optional
            capacity_reservation_id = string,
            # optional
            compartment_id = string,
            # optional
            dedicated_vm_host_id = string,
            # optional
            defined_tags = map(string),
            # optional
            freeform_tags = map(string),
            # optional
            display_name = string,
            # optional
            extended_metadata = map(string)
            # optional
            ipxe_script = string,
            # optional
            is_pv_encryption_in_transit_enabled = bool,
            # optional value in [NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM]
            launch_mode = string,
            # optional
            ssh_public_key_path = string,
            # optional - value in [LIVE_MIGRATE, REBOOT] - default = LIVE_MIGRATE
            preferred_maintenance_action = string,
            # optional
            shape = string,


            # optional
            agent_config = object({
              # optional - default = false
              are_all_plugins_disabled = bool,
              # optional - default = false
              is_management_disabled = bool,
              # optional - default = false
              is_monitoring_disabled = bool,
              # optional
              plugins_config = object({
                # required - value in [ENABLE, DISABLED]
                desired_state = string,
                # required - plugin name
                name = string,
              })
            })

            # Optional
            availability_config = object({
              # optional - value in [RESTORE_INSTANCE, STOP_INSTANCE]
              recovery_action = string,
            })

            # optional
            create_vnic_details = object({
              # optional
              assign_private_dns_record = bool,
              # optional
              assign_public_ip = bool,
              # optional
              defined_tags = map(string),
              # optional
              freeform_tags = map(string),
              # optional
              display_name = string,
              # optional
              hostname_label = string,
              # optional 
              nsg_ids = list(string),
              # optional
              private_ip = string,
              # optional
              skip_source_dest_check = bool,
              # optional
              subnet_id = string,
            })


            # optional
            instance_options = object({
              # optional - default = false
              are_legacy_imds_endpoints_disabled = bool
            })

            # optional
            launch_options = object({
              # optional - value in [ISCSI, SCSI, IDE, VFIO, PARAVIRTUALIZED]
              boot_volume_type = string,
              #optional - value in [BIOS, UEFI_64]
              firmware = string,
              # optional - default = false
              is_consistent_volume_naming_enabled = bool,
              # optional - deprecated
              is_pv_encryption_in_transit_enabled = bool,
              # optional - value in [E100, VIFO, PARAVIRTUALIZED]
              network_type = string,
              # optional - value in [ISCSI, SCSI, IDE, VFIO, PARAVIRTUALIZED]
              remote_data_volume_type = string
            })

            # optional
            platform_config = object({
              # required
              type = string,
              # optional - applicable when instance_type = compute
              is_measured_boot_enabled = bool,
              # optional - applicable when instance_type = compute
              is_secure_boot_enabled = bool,
              # optional - applicable when instance_type = compute
              is_trusted_platform_module_enabled = bool,
              # optional - applicable when type = Applicable when type=AMD_MILAN_BM
              numa_nodes_per_socket = number
            })

            # optional
            preemptible_instance_config = object({
              # required
              preemption_action = object({
                # required
                type = string
                # optional
                preserve_boot_volume = bool
              })
            })

            # optional
            shape_config = object({
              # optional - value in [BASELINE_1_8, BASELINE_1_2, BASELINE_1_1]. 
              baseline_ocpu_utilization = string,
              # optional
              memory_in_gbs = number,
              # optional
              nvmes = number,
              # optional
              ocpus = number
            })

            # optionals
            source_details = object({
              source_type = string,
              # optional - Applicable when source_type=bootVolume
              boot_volume_id = string,
              # optional - Applicable when source_type=image
              boot_volume_size_in_gbs = number,
              # optional -  Applicable when source_type=image
              image_id = string
            })

            ##### instance_options
          })

          # optional
          secondary_vnics = map(object({
            # optional
            display_name = string,
            # optional
            nic_index = number,
            # optional
            create_vnic_details = object({
              assign_private_dns_record = bool,
              assign_public_ip          = bool,
              defined_tags              = map(string),
              freeform_tags             = map(string),
              display_name              = string,
              hostname_label            = string,
              nsg_ids                   = list(string),
              private_ip                = string,
              skip_source_dest_check    = bool,
              subnet_id                 = string
            })
          }))

        })
      })

      # optional
      auto_scaling_configuration = object({
        # required
        auto_scaling_resources = object({
          # resource type
          type = string
        })
        # required
        compartment_id = string,

        #Optional
        cool_down_in_seconds = number,
        defined_tags         = map(string),
        display_name         = string,
        freeform_tags        = map(string),
        is_enabled           = bool

        # required
        policies = object({
          # Required value in [scheduled, threshold]
          policy_type = string,
          # optional 
          capacity = object({
            #Optional
            initial = number,
            max     = number,
            min     = number
          })
          # optional 
          display_name = string
          # required when policy_type=scheduled
          execution_schedule = object({
            # Required - cron expression in this format <second> <minute> <hour> <day of month> <month> <day of week> <year>
            expression = string,
            # required - The time zone for the execution schedule
            timezone = string,
            # required
            type = string
          })
          # optional
          is_enabled = bool,
          # required 
          resource_action = object({
            #Required
            action = string
            #Required
            action_type = string
          })
          # required
          rules = map(object({

            # required 
            action = object({

              # required
              type = string,
              # required 
              value = number
            })

            # Required when policy_type=threshold
            display_name = string,

            # Required when policy_type=threshold
            metric = object({

              # Required when policy_type=threshold
              metric_type = string
              # Required when policy_type=threshold
              threshold = object({

                # Required when policy_type=threshold
                operator = string,
                # Required when policy_type=threshold
                value = number
              })
            })
          }))
        })
      })
    })
  })
}