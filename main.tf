# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  aux = {
    id = "not_found"
  }

  non_poc_vcns = {
    for k, v in var.networking.prod_networking.vcns : k => {
      compartment_id    = lookup(module.oci-iam-compartments.compartments_config_flat, v.compartment_name, local.aux).id
      cidr              = v.cidr,
      dns_label         = v.dns_label,
      is_create_igw     = v.is_create_igw,
      is_attach_drg     = v.is_attach_drg,
      block_nat_traffic = v.block_nat_traffic,
      defined_tags      = v.defined_tags,
      freeform_tags     = v.freeform_tags
      subnets = {
        for k1, v1 in v.subnets : k1 => {
          compartment_id  = lookup(module.oci-iam-compartments.compartments_config_flat, v1.compartment_name, local.aux).id
          name            = k1
          defined_tags    = v1.defined_tags
          freeform_tags   = v1.freeform_tags
          cidr            = v1.cidr
          dns_label       = v1.dns_label
          dhcp_options_id = v1.dhcp_options_id
          security_lists  = v1.security_lists
          private         = v1.private
        }
      }
    }
  }
  prod_networking = {
    default_network_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.networking.prod_networking.default_network_compartment_name, local.aux).id
    service_label                  = var.networking.prod_networking.service_label
    service_gateway_cidr           = var.networking.prod_networking.service_gateway_cidr
    drg_id                         = var.networking.prod_networking.drg_id
    vcns                           = local.non_poc_vcns
  }

  poc_vcns = {
    for k, v in var.networking.stag_networking.vcns : k => {
      compartment_id    = lookup(module.oci-iam-compartments.compartments_config_flat, v.compartment_name, local.aux).id
      cidr              = v.cidr,
      dns_label         = v.dns_label,
      is_create_igw     = v.is_create_igw,
      is_attach_drg     = v.is_attach_drg,
      block_nat_traffic = v.block_nat_traffic,
      defined_tags      = v.defined_tags,
      freeform_tags     = v.freeform_tags
      subnets = {
        for k1, v1 in v.subnets : k1 => {
          compartment_id  = lookup(module.oci-iam-compartments.compartments_config_flat, v1.compartment_name, local.aux).id
          name            = k1
          defined_tags    = v1.defined_tags
          freeform_tags   = v1.freeform_tags
          cidr            = v1.cidr
          dns_label       = v1.dns_label
          dhcp_options_id = v1.dhcp_options_id
          security_lists  = v1.security_lists
          private         = v1.private
        }
      }
    }
  }

  stag_networking = {
    default_network_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.networking.stag_networking.default_network_compartment_name, local.aux).id
    service_label                  = var.networking.stag_networking.service_label
    service_gateway_cidr           = var.networking.stag_networking.service_gateway_cidr
    drg_id                         = var.networking.stag_networking.drg_id
    vcns                           = local.poc_vcns
  }

  app_network_security_list = [{
    for app_netsec_key, app_netsec_val in var.app_network_sec_config : app_netsec_key => {
      app_netsec_vcn_name    = app_netsec_key,
      default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, app_netsec_val.default_compartment_name, local.aux).id,
      vcn_name               = app_netsec_val.vcn_name,
      vcn_id                 = lookup(merge(module.oci-prod-network.networking_flat.vcns, module.oci-stag-network.networking_flat.vcns), app_netsec_val.vcn_name, local.aux).id,
      default_defined_tags   = app_netsec_val.default_defined_tags,
      default_freeform_tags  = app_netsec_val.default_freeform_tags,
      security_lists = {
        for seclist_key, seclist_value in app_netsec_val.security_lists : seclist_key => {
          compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, seclist_value.compartment_name, local.aux).id,
          defined_tags   = seclist_value.defined_tags,
          freeform_tags  = seclist_value.freeform_tags
          ingress_rules  = seclist_value.ingress_rules
          egress_rules   = seclist_value.egress_rules
        }
      }
      nsgs = {
        for nsg_key, nsg_value in app_netsec_val.nsgs : nsg_key => {
          compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, nsg_value.compartment_name, local.aux).id,
          defined_tags   = nsg_value.defined_tags,
          freeform_tags  = nsg_value.freeform_tags
          ingress_rules  = nsg_value.ingress_rules
          egress_rules   = nsg_value.egress_rules
        }
      }
    }
    }
  ]
  app_network_security_flat_list = flatten([for prjnetsec in local.app_network_security_list : [for k, v in prjnetsec : v]])
  app_network_security_map       = { for appnetsec in local.app_network_security_flat_list : appnetsec.app_netsec_vcn_name => appnetsec }

  local_event_rules = {
    default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.event_rules.default_compartment_name, local.aux).id,
    event_rules = {
      for k, v in var.event_rules.event_rules : k => {
        compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, v.compartment_name, local.aux).id
        condition      = v.condition
        display_name   = k
        description    = v.description
        is_enabled     = v.is_enabled
        actions        = v.actions
      }
    }
  }

  # Production Load Balancer

  load_balancer_config_prod = {
    default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.load_balancer_config.prod_lb.default_compartment_name, local.aux).id
    default_defined_tags   = var.load_balancer_config.prod_lb.default_defined_tags
    default_freeform_tags  = var.load_balancer_config.prod_lb.default_freeform_tags


    lb_options = {
      display_name   = var.load_balancer_config.prod_lb.lb_options.display_name
      compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.load_balancer_config.prod_lb.default_compartment_name, local.aux).id
      shape          = var.load_balancer_config.prod_lb.lb_options.shape
      subnet_ids = [
        for subnet_name in var.load_balancer_config.prod_lb.lb_options.subnet_ids : concat(flatten([
          for vcn in module.oci-prod-network.networking.vcns : [
          for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", subnet_name)[1]] if vcn.name == split(".", subnet_name)[0]
          ]),
          flatten([
            for vcn in module.oci-stag-network.networking.vcns : [
            for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", subnet_name)[1]] if vcn.name == split(".", subnet_name)[0]
      ]))[0]]
      private       = var.load_balancer_config.prod_lb.lb_options.private
      nsg_ids       = var.load_balancer_config.prod_lb.lb_options.nsg_ids
      defined_tags  = var.load_balancer_config.prod_lb.lb_options.defined_tags
      freeform_tags = var.load_balancer_config.prod_lb.lb_options.freeform_tags

    }

    health_checks = var.load_balancer_config.prod_lb.health_checks

    backend_sets = var.load_balancer_config.prod_lb.backend_sets

    path_route_sets = var.load_balancer_config.prod_lb.path_route_sets
    rule_sets       = var.load_balancer_config.prod_lb.rule_sets

    listeners = var.load_balancer_config.prod_lb.listeners
  }

  # Staging Load Balancer

  load_balancer_config_stag = {
    default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.load_balancer_config.stag_lb.default_compartment_name, local.aux).id
    default_defined_tags   = var.load_balancer_config.stag_lb.default_defined_tags
    default_freeform_tags  = var.load_balancer_config.stag_lb.default_freeform_tags


    lb_options = {
      display_name   = var.load_balancer_config.stag_lb.lb_options.display_name
      compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.load_balancer_config.stag_lb.default_compartment_name, local.aux).id
      shape          = var.load_balancer_config.stag_lb.lb_options.shape
      subnet_ids = [
        for subnet_name in var.load_balancer_config.stag_lb.lb_options.subnet_ids : concat(flatten([
          for vcn in module.oci-prod-network.networking.vcns : [
          for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", subnet_name)[1]] if vcn.name == split(".", subnet_name)[0]
          ]),
          flatten([
            for vcn in module.oci-stag-network.networking.vcns : [
            for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", subnet_name)[1]] if vcn.name == split(".", subnet_name)[0]
      ]))][0]
      private       = var.load_balancer_config.stag_lb.lb_options.private
      nsg_ids       = var.load_balancer_config.stag_lb.lb_options.nsg_ids
      defined_tags  = var.load_balancer_config.stag_lb.lb_options.defined_tags
      freeform_tags = var.load_balancer_config.stag_lb.lb_options.freeform_tags

    }

    health_checks = var.load_balancer_config.stag_lb.health_checks

    backend_sets = var.load_balancer_config.stag_lb.backend_sets

    path_route_sets = var.load_balancer_config.stag_lb.path_route_sets
    rule_sets       = var.load_balancer_config.stag_lb.rule_sets

    listeners = var.load_balancer_config.stag_lb.listeners
  }

  # Production instance pool
  instance_pool_config_prod = var.instance_pool_config.instance_pool_stag != null ? {
    default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_prod.default_compartment_name, local.aux).id
    default_defined_tags   = var.instance_pool_config.instance_pool_prod.default_defined_tags
    default_freeform_tags  = var.instance_pool_config.instance_pool_prod.default_freeform_tags

    instance_pool = {
      compartment_id = var.instance_pool_config.instance_pool_prod.instance_pool.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_prod.instance_pool.compartment_name, local.aux).id : null
      size           = var.instance_pool_config.instance_pool_prod.instance_pool.size
      defined_tags   = var.instance_pool_config.instance_pool_prod.instance_pool.defined_tags
      freeform_tags  = var.instance_pool_config.instance_pool_prod.instance_pool.freeform_tags
      display_name   = var.instance_pool_config.instance_pool_prod.instance_pool.display_name

      # required
      placements_configurations = {
        # required
        ad = var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.ad
        # optional
        fd = var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.fd
        # required
        primary_subnet_id = concat(flatten([
          for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.primary_subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.primary_subnet_name)[0]
          ]),
          flatten([
            for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.primary_subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.primary_subnet_name)[0]
        ]))[0]

        #optional
        secondary_vnic_subnets = {
          for k, v in var.instance_pool_config.instance_pool_prod.instance_pool.placements_configurations.secondary_vnic_subnets : k => {
            subnet_id = concat(flatten([
              for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", v.subnet_name)[1]] if vcn.name == split(".", v.subnet_name)[0]
              ]),
              flatten([
                for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", v.subnet_name)[1]] if vcn.name == split(".", v.subnet_name)[0]
            ]))[0]

            display_name = v.display_name
          }
        }
      }

      # optional
      #load_balancers = {}

      load_balancers = {
        for lb_key, lb_value in var.instance_pool_config.instance_pool_prod.instance_pool.load_balancers : lb_key => {
          load_balancer_id = [for lb in module.oci-lb-prod.load_balancer.lb : lb.id if lb.display_name == lb_value.load_balancer_name][0]
          backend_set_name = lb_value.backend_set_name
          port             = lb_value.port
          vnic_selection   = lb_value.vnic_selection

        }
      }


      instance_configuration = {
        # required
        compartment_id = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.compartment_name, local.aux).id : null

        #optional 
        defined_tags  = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.defined_tags
        freeform_tags = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.freeform_tags
        display_name  = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.display_name

        # optional - Default = NONE; Values = ["NONE, INSTANCE"]
        source = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.source
        # Required when source=INSTANCE
        instance_id = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_id
        # required 
        instance_details = {

          # required - The type of instance details. Supported instanceType is compute
          instance_type = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.instance_type

          # optional
          block_volumes = {
            for k, v in var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.block_volumes : k => {
              # optional 
              attach_details = v.attach_details

              # optional - creates a new block volume
              create_details = {
                ad               = v.create_details.ad
                backup_policy_id = v.create_details.backup_policy_id
                compartment_name = lookup(module.oci-iam-compartments.compartments_config_flat, v.create_details.compartment_name, local.aux).id
                defined_tags     = v.create_details.defined_tags
                freeform_tags    = v.create_details.freeform_tags
                display_name     = v.create_details.display_name
                kms_key_id       = v.create_details.kms_key_id
                size_in_gbs      = v.create_details.size_in_gbs
                # optional - value in [0(lower cost), 10(balanced option), 20(high performance), 30(ultra high performance)]
                vpus_per_gb = v.create_details.vpus_per_gb
                volume_id   = v.create_details.volume_id

                # optional
                source_details = v.create_details.source_details
              }
            }
          }

          # optional
          launch_details = {
            # optional
            ad = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.ad
            # optional
            fd = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.fd
            # optional
            capacity_reservation_id = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.capacity_reservation_id
            # optional
            compartment_id = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.compartment_name, local.aux).id : null
            # optional
            dedicated_vm_host_id = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.dedicated_vm_host_id
            # optional
            defined_tags = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.defined_tags
            # optional
            freeform_tags = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.freeform_tags
            # optional
            display_name = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.display_name
            # optional
            extended_metadata = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.extended_metadata
            # optional
            ipxe_script = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.ipxe_script
            # optional
            is_pv_encryption_in_transit_enabled = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.is_pv_encryption_in_transit_enabled
            # optional value in [NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM]
            launch_mode = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.launch_mode
            # optional
            ssh_public_key_path = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.ssh_public_key_path
            # optional - value in [LIVE_MIGRATE, REBOOT] - default = LIVE_MIGRATE
            preferred_maintenance_action = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.preferred_maintenance_action
            # optional
            shape = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.shape
            # optional
            agent_config = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.agent_config
            # optional
            availability_config = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.availability_config

            create_vnic_details = {
              # optional
              assign_private_dns_record = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.assign_private_dns_record
              # optional
              assign_public_ip = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.assign_public_ip
              # optional
              defined_tags = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.defined_tags
              # optional
              freeform_tags = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.freeform_tags
              # optional
              display_name = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.display_name
              # optional
              hostname_label = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.hostname_label
              # optional 
              nsg_ids = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.nsg_ids
              # optional
              private_ip = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.private_ip
              # optional
              skip_source_dest_check = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.skip_source_dest_check
              # optional
              subnet_id = concat(flatten([
                for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[0]
                ]),
                flatten([
                  for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[0]
              ]))[0]
            }

            # optional
            instance_options = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.instance_options

            # optional
            launch_options = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.launch_options
            # optional
            platform_config = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.platform_config

            # optional
            preemptible_instance_config = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.preemptible_instance_config

            # optional
            shape_config = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.shape_config

            # optionals
            source_details = var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.launch_details.source_details
          }

          # optional
          secondary_vnics = {
            for vnic_k, vnic_v in var.instance_pool_config.instance_pool_prod.instance_pool.instance_configuration.instance_details.secondary_vnics : vnic_k => {
              assign_private_dns_record = vnic_v.assign_private_dns_record
              assign_public_ip          = vnic_v.assign_public_ip
              defined_tags              = vnic_v.defined_tags
              freeform_tags             = vnic_v.freeform_tags
              display_name              = vnic_v.display_name
              hostname_label            = vnic_v.hostname_label
              nsg_ids                   = vnic_v.nsg_ids
              private_ip                = vnic_v.private_ip
              skip_source_dest_check    = vnic_v.skip_source_dest_check
              subnet_id = concat(flatten([
                for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", vnic_v.subnet_name)[1]] if vcn.name == split(".", vnic_v.subnet_name)[0]
                ]),
                flatten([
                  for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", vnic_v.subnet_name)[1]] if vcn.name == split(".", vnic_v.subnet_name)[0]
              ]))[0]
            }
          }

        }
      }

      # optional
      auto_scaling_configuration = {

        auto_scaling_resources = {
          # resource type
          type = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.auto_scaling_resources.type
        }
        # required
        compartment_id = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.compartment_name, local.aux).id : null

        #Optional
        cool_down_in_seconds = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.cool_down_in_seconds
        defined_tags         = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.defined_tags
        display_name         = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.display_name
        freeform_tags        = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.freeform_tags
        is_enabled           = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.is_enabled

        # required
        policies = var.instance_pool_config.instance_pool_prod.instance_pool.auto_scaling_configuration.policies
      }
    }

  } : null

  # Staging instance pool
  instance_pool_config_stag = var.instance_pool_config.instance_pool_stag != null ? {
    default_compartment_id = lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_stag.default_compartment_name, local.aux).id
    default_defined_tags   = var.instance_pool_config.instance_pool_stag.default_defined_tags
    default_freeform_tags  = var.instance_pool_config.instance_pool_stag.default_freeform_tags

    instance_pool = {
      compartment_id = var.instance_pool_config.instance_pool_stag.instance_pool.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_stag.instance_pool.compartment_name, local.aux).id : null
      size           = var.instance_pool_config.instance_pool_stag.instance_pool.size
      defined_tags   = var.instance_pool_config.instance_pool_stag.instance_pool.defined_tags
      freeform_tags  = var.instance_pool_config.instance_pool_stag.instance_pool.freeform_tags
      display_name   = var.instance_pool_config.instance_pool_stag.instance_pool.display_name

      # required
      placements_configurations = {
        # required
        ad = var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.ad
        # optional
        fd = var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.fd
        # required
        primary_subnet_id = concat(flatten([
          for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.primary_subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.primary_subnet_name)[0]
          ]),
          flatten([
            for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.primary_subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.primary_subnet_name)[0]
        ]))[0]

        #optional
        secondary_vnic_subnets = {
          for k, v in var.instance_pool_config.instance_pool_stag.instance_pool.placements_configurations.secondary_vnic_subnets : k => {
            subnet_id = concat(flatten([
              for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", v.subnet_name)[1]] if vcn.name == split(".", v.subnet_name)[0]
              ]),
              flatten([
                for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", v.subnet_name)[1]] if vcn.name == split(".", v.subnet_name)[0]
            ]))[0]

            display_name = v.display_name
          }
        }
      }

      # optional
      #load_balancers = {}

      load_balancers = {
        for lb_key, lb_value in var.instance_pool_config.instance_pool_stag.instance_pool.load_balancers : lb_key => {
          load_balancer_id = [for lb in module.oci-lb-stag.load_balancer.lb : lb.id if lb.display_name == lb_value.load_balancer_name][0]
          backend_set_name = lb_value.backend_set_name
          port             = lb_value.port
          vnic_selection   = lb_value.vnic_selection

        }
      }


      instance_configuration = {
        # required
        compartment_id = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.compartment_name, local.aux).id : null

        #optional 
        defined_tags  = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.defined_tags
        freeform_tags = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.freeform_tags
        display_name  = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.display_name

        # optional - Default = NONE; Values = ["NONE, INSTANCE"]
        source = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.source
        # Required when source=INSTANCE
        instance_id = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_id
        # required 
        instance_details = {

          # required - The type of instance details. Supported instanceType is compute
          instance_type = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.instance_type

          # optional
          block_volumes = {
            for k, v in var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.block_volumes : k => {
              # optional 
              attach_details = v.attach_details

              # optional - creates a new block volume
              create_details = {
                ad               = v.create_details.ad
                backup_policy_id = v.create_details.backup_policy_id
                compartment_name = lookup(module.oci-iam-compartments.compartments_config_flat, v.create_details.compartment_name, local.aux).id
                defined_tags     = v.create_details.defined_tags
                freeform_tags    = v.create_details.freeform_tags
                display_name     = v.create_details.display_name
                kms_key_id       = v.create_details.kms_key_id
                size_in_gbs      = v.create_details.size_in_gbs
                # optional - value in [0(lower cost), 10(balanced option), 20(high performance), 30(ultra high performance)]
                vpus_per_gb = v.create_details.vpus_per_gb
                volume_id   = v.create_details.volume_id

                # optional
                source_details = v.create_details.source_details
              }
            }
          }

          # optional
          launch_details = {
            # optional
            ad = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.ad
            # optional
            fd = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.fd
            # optional
            capacity_reservation_id = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.capacity_reservation_id
            # optional
            compartment_id = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.compartment_name, local.aux).id : null
            # optional
            dedicated_vm_host_id = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.dedicated_vm_host_id
            # optional
            defined_tags = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.defined_tags
            # optional
            freeform_tags = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.freeform_tags
            # optional
            display_name = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.display_name
            # optional
            extended_metadata = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.extended_metadata
            # optional
            ipxe_script = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.ipxe_script
            # optional
            is_pv_encryption_in_transit_enabled = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.is_pv_encryption_in_transit_enabled
            # optional value in [NATIVE, EMULATED, PARAVIRTUALIZED, CUSTOM]
            launch_mode = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.launch_mode
            # optional
            ssh_public_key_path = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.ssh_public_key_path
            # optional - value in [LIVE_MIGRATE, REBOOT] - default = LIVE_MIGRATE
            preferred_maintenance_action = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.preferred_maintenance_action
            # optional
            shape = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.shape
            # optional
            agent_config = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.agent_config
            # optional
            availability_config = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.availability_config

            create_vnic_details = {
              # optional
              assign_private_dns_record = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.assign_private_dns_record
              # optional
              assign_public_ip = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.assign_public_ip
              # optional
              defined_tags = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.defined_tags
              # optional
              freeform_tags = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.freeform_tags
              # optional
              display_name = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.display_name
              # optional
              hostname_label = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.hostname_label
              # optional 
              nsg_ids = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.nsg_ids
              # optional
              private_ip = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.private_ip
              # optional
              skip_source_dest_check = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.skip_source_dest_check
              # optional
              subnet_id = concat(flatten([
                for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[0]
                ]),
                flatten([
                  for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[1]] if vcn.name == split(".", var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.create_vnic_details.subnet_name)[0]
              ]))[0]
            }

            # optional
            instance_options = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.instance_options

            # optional
            launch_options = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.launch_options
            # optional
            platform_config = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.platform_config

            # optional
            preemptible_instance_config = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.preemptible_instance_config

            # optional
            shape_config = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.shape_config

            # optionals
            source_details = var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.launch_details.source_details
          }

          # optional
          secondary_vnics = {
            for vnic_k, vnic_v in var.instance_pool_config.instance_pool_stag.instance_pool.instance_configuration.instance_details.secondary_vnics : vnic_k => {
              assign_private_dns_record = vnic_v.assign_private_dns_record
              assign_public_ip          = vnic_v.assign_public_ip
              defined_tags              = vnic_v.defined_tags
              freeform_tags             = vnic_v.freeform_tags
              display_name              = vnic_v.display_name
              hostname_label            = vnic_v.hostname_label
              nsg_ids                   = vnic_v.nsg_ids
              private_ip                = vnic_v.private_ip
              skip_source_dest_check    = vnic_v.skip_source_dest_check
              subnet_id = concat(flatten([
                for vcn in module.oci-prod-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", vnic_v.subnet_name)[1]] if vcn.name == split(".", vnic_v.subnet_name)[0]
                ]),
                flatten([
                  for vcn in module.oci-stag-network.networking.vcns : [for subnet in vcn.subnets : subnet.id if subnet.display_name == split(".", vnic_v.subnet_name)[1]] if vcn.name == split(".", vnic_v.subnet_name)[0]
              ]))[0]
            }
          }

        }
      }

      # optional
      auto_scaling_configuration = {

        auto_scaling_resources = {
          # resource type
          type = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.auto_scaling_resources.type
        }
        # required
        compartment_id = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.compartment_name != null ? lookup(module.oci-iam-compartments.compartments_config_flat, var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.compartment_name, local.aux).id : null

        #Optional
        cool_down_in_seconds = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.cool_down_in_seconds
        defined_tags         = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.defined_tags
        display_name         = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.display_name
        freeform_tags        = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.freeform_tags
        is_enabled           = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.is_enabled

        # required
        policies = var.instance_pool_config.instance_pool_stag.instance_pool.auto_scaling_configuration.policies
      }
    }

  } : null
}







module "oci-iam-compartments" {

  source = "./modules/oci-iam-compartments"

  providers = {
    oci.home = oci.home
  }

  compartments_config = var.app_compartments_config
}

module "oci-prod-network" {

  source     = "./modules/oci-network"
  depends_on = [module.oci-iam-compartments]

  providers = {
    oci = oci
  }

  networking = local.prod_networking
}

module "oci-stag-network" {

  source     = "./modules/oci-network"
  depends_on = [module.oci-iam-compartments]

  providers = {
    oci = oci
  }

  networking = local.stag_networking
}

module "oci-network-security" {

  source     = "./modules/oci-network-security"
  depends_on = [module.oci-iam-compartments, module.oci-stag-network, module.oci-prod-network]

  for_each = local.app_network_security_map

  providers = {
    oci = oci
  }

  network_security = each.value
}

module "oci-monitoring" {

  source     = "./modules/oci-monitoring"
  depends_on = [module.oci-iam-compartments, module.oci-stag-network, module.oci-prod-network]

  providers = {
    oci = oci
  }

  default_compartment_id = local.local_event_rules.default_compartment_id
  event_rules            = local.local_event_rules.event_rules
}

module "oci-lb-prod" {

  source     = "./modules/oci-load-balancer"
  depends_on = [module.oci-iam-compartments, module.oci-stag-network, module.oci-prod-network]

  providers = {
    oci = oci
  }

  load_balancer_config = local.load_balancer_config_prod
}

module "oci-lb-stag" {

  source     = "./modules/oci-load-balancer"
  depends_on = [module.oci-iam-compartments, module.oci-stag-network, module.oci-stag-network]

  providers = {
    oci = oci
  }

  load_balancer_config = local.load_balancer_config_stag
}

module "oci-instance-pool-prod" {

  source     = "./modules/oci-instance-pool"
  depends_on = [module.oci-iam-compartments, module.oci-prod-network, module.oci-lb-prod]

  providers = {
    oci = oci
  }

  instance_pool_config = local.instance_pool_config_prod

}

module "oci-instance-pool-stag" {

  source     = "./modules/oci-instance-pool"
  depends_on = [module.oci-iam-compartments, module.oci-stag-network, module.oci-lb-stag]

  providers = {
    oci = oci
  }

  instance_pool_config = local.instance_pool_config_prod

}



