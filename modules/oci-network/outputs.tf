# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


output "networking" {
  value = {
    vcns = {
      for vcn_key, vcn_value in module.opco_vcns.vcns : vcn_key => {
        name                     = vcn_key,
        cidr_block               = vcn_value.cidr_block,
        default_security_list_id = vcn_value.default_security_list_id,
        dns_label                = vcn_value.dns_label,
        id                       = vcn_value.id
        subnets = {
          for subnet_key, subnet_value in module.opco_vcns.subnets : subnet_key => {
            display_name               = subnet_key,
            availability_domain        = subnet_value.availability_domain,
            cidr_block                 = subnet_value.cidr_block,
            compartment_id             = subnet_value.compartment_id,
            defined_tags               = subnet_value.defined_tags,
            dhcp_options_id            = subnet_value.dhcp_options_id,
            dns_label                  = subnet_value.dns_label,
            freeform_tags              = subnet_value.freeform_tags,
            id                         = subnet_value.id,
            ipv6cidr_block             = subnet_value.ipv6cidr_block,
            ipv6virtual_router_ip      = subnet_value.ipv6virtual_router_ip,
            prohibit_internet_ingress  = subnet_value.prohibit_internet_ingress,
            prohibit_public_ip_on_vnic = subnet_value.prohibit_public_ip_on_vnic,
            route_table_id             = subnet_value.route_table_id,
            security_list_ids          = subnet_value.security_list_ids,
            state                      = subnet_value.state,
            subnet_domain_name         = subnet_value.subnet_domain_name,
            time_created               = subnet_value.time_created,
            timeouts                   = subnet_value.timeouts,
            vcn_id                     = subnet_value.vcn_id,
            virtual_router_mac         = subnet_value.virtual_router_mac
          } if subnet_value.vcn_id == vcn_value.id
        },
        internet_gateways = {
          for ig_key, ig_value in module.opco_vcns.internet_gateways : ig_value.display_name => {
            compartment_id = ig_value.compartment_id,
            defined_tags   = ig_value.defined_tags,
            display_name   = ig_value.display_name,
            enabled        = ig_value.enabled,
            freeform_tags  = ig_value.freeform_tags,
            id             = ig_value.id,
            state          = ig_value.state,
            time_created   = ig_value.time_created,
            timeouts       = ig_value.timeouts,
            vcn_id         = ig_value.vcn_id,
          } if ig_value.vcn_id == vcn_value.id
        },
        nat_gateways = {
          for ng_key, ng_value in module.opco_vcns.nat_gateways : ng_value.display_name => {
            block_traffic  = ng_value.block_traffic,
            compartment_id = ng_value.compartment_id,
            defined_tags   = ng_value.defined_tags,
            display_name   = ng_value.display_name,
            freeform_tags  = ng_value.freeform_tags,
            id             = ng_value.id,
            nat_ip         = ng_value.nat_ip,
            public_ip_id   = ng_value.public_ip_id,
            state          = ng_value.state,
            time_created   = ng_value.time_created,
            timeouts       = ng_value.timeouts,
            vcn_id         = ng_value.vcn_id
          } if ng_value.vcn_id == vcn_value.id
        },
        service_gateways = {
          for sg_key, sg_value in module.opco_vcns.service_gateways : sg_value.display_name => {
            block_traffic  = sg_value.block_traffic,
            compartment_id = sg_value.compartment_id,
            defined_tags   = sg_value.defined_tags,
            display_name   = sg_value.display_name,
            freeform_tags  = sg_value.freeform_tags,
            id             = sg_value.id,
            route_table_id = sg_value.route_table_id,
            services       = sg_value.services,
            state          = sg_value.state,
            time_created   = sg_value.time_created,
            timeouts       = sg_value.timeouts,
            vcn_id         = sg_value.vcn_id
          } if sg_value.vcn_id == vcn_value.id
        }
      }
    }
  }
}

output "networking_flat" {
  value = {
    vcns              = module.opco_vcns.vcns,
    subnets           = module.opco_vcns.subnets,
    internet_gateways = module.opco_vcns.internet_gateways
    nat_gateways      = module.opco_vcns.nat_gateways
    service_gateways  = module.opco_vcns.service_gateways
    security_lists    = module.opco_vcns.security_lists
    all_services      = module.opco_vcns.all_services
  }
}
