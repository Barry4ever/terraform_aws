module "eks" {
    source = "terraform-aws-modules/eks/aws"
  version = "18.26.6"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_addons = {
    coredns = {
        most_recent = true
    }
    kube-proxy = {
        most_recent = true
     }
  vpc-cni = {
        most_recent = true
  }
}

  subnet_ids = modules.vpc.private_subnets
  vpc_id = modules.vpc.vpc_id
  eks_managed_node_groups = {
    dev = {
      min_size = 1
      max_size = 3
      desired_size = 2
      instance_types = var.instance_type
    }
  }
  tags = {
    Environment = "training"
    GithubRepo = "terraform-aws-eks"
    GithubOrg = "terraform-aws-modules"
  }
}