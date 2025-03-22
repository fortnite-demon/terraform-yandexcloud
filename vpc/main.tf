data "yandex_client_config" "client" {}

locals {
  folder_id      = var.folder_id != null ? var.folder_id : data.yandex_client_config.client.folder_id
  zone           = var.zone != null ? var.zone : data.yandex_client_config.client.zone
  create_network = var.create_network && var.exists_network_id == null ? true : false
}

resource "yandex_vpc_network" "this" {
  count = local.create_network ? 1 : 0

  name      = var.network_name
  folder_id = local.folder_id
}

resource "yandex_vpc_subnet" "public_subnets" {
  for_each = var.public_subnets != null ? {
    for v in var.public_subnets : v.v4_cidr_blocks[0] => v
  } : {}

  network_id     = local.create_network ? yandex_vpc_network.this[0].id : var.exists_network_id
  name           = each.value.name
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = coalesce(each.value.zone, local.zone)
  folder_id      = coalesce(each.value.folder_id, local.folder_id)
  route_table_id = var.public_route_table_name != null ? yandex_vpc_route_table.public_subnets_route[0].id : null
}

resource "yandex_vpc_subnet" "private_subnets" {
  for_each = var.private_subnets != null ? {
    for v in var.private_subnets : v.v4_cidr_blocks[0] => v
  } : {}

  network_id     = local.create_network ? yandex_vpc_network.this[0].id : var.exists_network_id
  name           = each.value.name
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = coalesce(each.value.zone, local.zone)
  folder_id      = coalesce(each.value.folder_id, local.folder_id)
  route_table_id = var.private_subnets_route_table != null ? yandex_vpc_route_table.private_subnets_route[0].id : null
}

resource "yandex_vpc_gateway" "nat_gw" {
  count = var.create_nat_gw ? 1 : 0

  name      = var.nat_gw.name
  folder_id = coalesce(var.nat_gw.folder_id, local.folder_id)
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private_subnets_route" {
  count = var.create_nat_gw && var.private_subnets != null || var.private_subnets_route_table != null ? 1 : 0

  name       = var.private_route_table_name
  folder_id  = local.folder_id
  network_id = local.create_network ? yandex_vpc_network.this[0].id : var.exists_network_id

  dynamic "static_route" {
    for_each = var.create_nat_gw ? ["nat-gw"] : []
    content {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gw[0].id
    }
  }

  dynamic "static_route" {
    for_each = var.private_subnets_route_table != null ? var.private_subnets_route_table : []
    content {
      destination_prefix = static_route.value.destination_prefix
      next_hop_address   = static_route.value.next_hop_address
    }
  }
}

resource "yandex_vpc_route_table" "public_subnets_route" {
  count = var.public_subnets_route_table != null ? 1 : 0

  name       = var.public_route_table_name
  folder_id  = local.folder_id
  network_id = local.create_network ? yandex_vpc_network.this[0].id : var.exists_network_id

  dynamic "static_route" {
    for_each = var.public_subnets_route_table != null ? var.public_subnets_route_table : []
    content {
      destination_prefix = static_route.value.destination_prefix
      next_hop_address   = static_route.value.next_hop_address
    }
  }
}
