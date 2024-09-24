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
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-vpc"
    Team = var.tags.Team
  }
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
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-public-${element(data.aws_availability_zones.available.names, count.index)}"
    Team = var.tags.Team
  }
}

resource "aws_subnet" "private" {
  count             = var.create_subnets ? local.azs_count : 0
  vpc_id            = local.vpc_id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 20 + count.index)
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-private-${element(data.aws_availability_zones.available.names, count.index)}"
    Team = var.tags.Team
  }
}

locals {
  public_subnet_ids  = var.create_subnets ? [for s in aws_subnet.public : s.id] : var.existing_subnet_ids_public
  private_subnet_ids = var.create_subnets ? [for s in aws_subnet.private : s.id] : var.existing_subnet_ids_private
}

resource "aws_eip" "nat" {
  count = local.azs_count
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-nat-eip-${local.azs_names[count.index]}"
    Team = var.tags.Team
  }
}

resource "aws_nat_gateway" "main" {
  count         = local.azs_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = local.public_subnet_ids[count.index]
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-nat-${local.azs_names[count.index]}"
    Team = var.tags.Team
  }
}

resource "aws_internet_gateway" "main" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = local.vpc_id
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-igw"
    Team = var.tags.Team
  }
}

locals {
  internet_gateway_id = var.create_internet_gateway ? aws_internet_gateway.main[0].id : var.existing_internet_gateway_id
}

resource "aws_route_table" "public" {
  count  = var.create_route_tables ? 1 : 0
  vpc_id = local.vpc_id
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-rt-public"
    Team = var.tags.Team
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.internet_gateway_id
  }
}

locals {
  public_route_table_id = var.create_route_tables ? aws_route_table.public[0].id : var.existing_public_route_table_id
}

resource "aws_route_table_association" "public" {
  count          = var.create_subnets ? local.azs_count : 0
  subnet_id      = element(local.public_subnet_ids, count.index)
  route_table_id = local.public_route_table_id
}

resource "aws_route_table" "private" {
  count  = var.create_route_tables ? 1 : 0
  vpc_id = local.vpc_id
  tags = {
    Name = "${local.kebab_case_prefix}-ecs-rt-private"
    Team = var.tags.Team
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }
}

locals {
  private_route_table_id = var.create_route_tables ? aws_route_table.private[0].id : var.existing_private_route_table_id
}

resource "aws_route_table_association" "private" {
  count          = var.create_subnets ? local.azs_count : 0
  subnet_id      = element(local.private_subnet_ids, count.index)
  route_table_id = local.private_route_table_id
}