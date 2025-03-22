# vpc

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.11.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | = 0.135 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.135.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_gateway.nat_gw](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_gateway) | resource |
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.private_subnets_route](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_route_table.public_subnets_route](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_subnet.private_subnets](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.public_subnets](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/resources/vpc_subnet) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/0.135/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_nat_gw"></a> [create\_nat\_gw](#input\_create\_nat\_gw) | (Optional) - Wether create nat gateway for private subnets. Default: false | `bool` | `false` | no |
| <a name="input_create_network"></a> [create\_network](#input\_create\_network) | (Optional) - Whether create network. Default: true, <br/>  if set false, then exists\_network\_id is REQUIRED! | `bool` | `true` | no |
| <a name="input_exists_network_id"></a> [exists\_network\_id](#input\_exists\_network\_id) | (Optional) - Exists network id. If create\_network is false, then REQUIRED! | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Optional) - Yandex Cloud folder id, if not provided, then will be get from: client\_config | `string` | `null` | no |
| <a name="input_nat_gw"></a> [nat\_gw](#input\_nat\_gw) | (Optional) - Specific settings of the nat gateway. | <pre>object({<br/>    name      = optional(string, "default-nat-gateway")<br/>    folder_id = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | (Optional) - Network name. Default: default-network | `string` | `"default-network"` | no |
| <a name="input_private_route_table_name"></a> [private\_route\_table\_name](#input\_private\_route\_table\_name) | (Optional) - Name of the private route table. | `string` | `"default-private-route-table"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | (Optional) - List of the private subnets. Default: null | <pre>list(object({<br/>    v4_cidr_blocks = list(string)<br/>    zone           = optional(string)<br/>    name           = optional(string)<br/>    folder_id      = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_private_subnets_route_table"></a> [private\_subnets\_route\_table](#input\_private\_subnets\_route\_table) | (Optional) - Route table of the private subnets. Default: null | <pre>list(object({<br/>    destination_prefix = string<br/>    next_hop_address   = string<br/>  }))</pre> | `null` | no |
| <a name="input_public_route_table_name"></a> [public\_route\_table\_name](#input\_public\_route\_table\_name) | (Optional) - Name of the public route table. | `string` | `"default-public-route-table"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | (Optional) - List of the public subnets. Default: null | <pre>list(object({<br/>    v4_cidr_blocks = list(string)<br/>    zone           = optional(string)<br/>    name           = optional(string)<br/>    folder_id      = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_public_subnets_route_table"></a> [public\_subnets\_route\_table](#input\_public\_subnets\_route\_table) | (Optional) - Route table of the public subnets. Default: null | <pre>list(object({<br/>    destination_prefix = string<br/>    next_hop_address   = string<br/>  }))</pre> | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) - Yandex Cloud default availability zone, if not provided, then will be get from: client\_config | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gw"></a> [nat\_gw](#output\_nat\_gw) | n/a |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | n/a |
| <a name="output_private_route_table"></a> [private\_route\_table](#output\_private\_route\_table) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_route_table"></a> [public\_route\_table](#output\_public\_route\_table) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
