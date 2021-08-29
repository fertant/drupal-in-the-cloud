environment = "DEV"
product = "jacobdelafon"
sub_product = "web"
contact = "andrii_shutov@epam.com"
cost_code = "jacobdelafon"
orchestration = "git@bitbucket.org:kohler_source/jacob-delafon-devops.git"
description = "JacobDelafon websites"

region          = "eu-west-3"
vpc_name        = "jd-dev-fr"
vpc_subnet_cidr = "172.16.0.0/16"
public_subnets  = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
private_subnets = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]

instance_types   = "t3.medium"
desired_capacity = 1
min_capacity     = 1
max_capacity     = 1