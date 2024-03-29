data "aws-vpc" "default" {
    default = true
}

data "aws_subnets" "all" {
    filter {
      name = "vcp-id"
      values = [data.aws_vpc.default.id]
    }
}

output "first_subnet_id" {
    value = sort(data.aws_subnets.all.ids)[0]
  
}