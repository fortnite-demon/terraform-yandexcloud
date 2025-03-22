output "network_id" {
  value = local.create_network ? yandex_vpc_network.this[0].id : var.exists_network_id
}

output "public_subnets" {
  value = yandex_vpc_subnet.public_subnets != null ? [
    for v in yandex_vpc_subnet.public_subnets : {
      subnet_id      = v.id
      name           = v.name
      v4_cidr_blocks = v.v4_cidr_blocks
      zone           = v.zone
    }
  ] : []
}

output "private_subnets" {
  value = yandex_vpc_subnet.private_subnets != null ? [
    for v in yandex_vpc_subnet.private_subnets : {
      subnet_id      = v.id
      name           = v.name
      v4_cidr_blocks = v.v4_cidr_blocks
      zone           = v.zone
    }
  ] : []
}

output "private_route_table" {
  value = try(yandex_vpc_route_table.private_subnets_route[0].id, "")
}

output "public_route_table" {
  value = try(yandex_vpc_route_table.public_subnets_route[0].id, "")
}

output "nat_gw" {
  value = try(yandex_vpc_gateway.nat_gw[0].id, "")
}