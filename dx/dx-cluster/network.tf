data "aws_availability_zones" "available" { state = "available" }

locals {
  azs_count = 2
  azs_names = data.aws_availability_zones.available.names
}

resource "aws_vpc" "main" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { Name = "${local.kebab_case_prefix}-ecs-vpc" }
}

locals {
  vpc_id = var.create_vpc ? aws_vpc.main[0].id : var.existing_vpc_id
}

resource "aws_subnet" "public" {
  count                   = var.create_subnets ? local.azs_count : 0
  vpc_id                  = local.vpc_id
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 10 + count.index)
  map_public_ip_on_launch = true
  tags                    = { Name = "${local.kebab_case_prefix}-ecs-public-${element(data.aws_availability_zones.available.names, count.index)}" }
}

resource "aws_subnet" "private" {
  count             = var.create_subnets ? local.azs_count : 0
  vpc_id            = local.vpc_id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 20 + count.index)
  tags              = { Name = "${local.kebab_case_prefix}-ecs-private-${element(data.aws_availability_zones.available.names, count.index)}" }
}

locals {
  public_subnet_ids  = var.create_subnets ? [for s in aws_subnet.public : s.id] : var.existing_subnet_ids_public
  private_subnet_ids = var.create_subnets ? [for s in aws_subnet.private : s.id] : var.existing_subnet_ids_private
}

resource "aws_eip" "nat" {
  count = local.azs_count
  tags  = { Name = "${local.kebab_case_prefix}-ecs-nat-eip-${local.azs_names[count.index]}" }
}

resource "aws_nat_gateway" "main" {
  count         = local.azs_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = local.public_subnet_ids[count.index]
  tags          = { Name = "${local.kebab_case_prefix}-ecs-nat-${local.azs_names[count.index]}" }
}
