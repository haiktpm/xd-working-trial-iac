module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "18.29.0"
  cluster_name                    = "xd-trial"
  cluster_version                 = "1.22"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_addons                  = {
    coredns                       = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy                    = {}
    vpc-cni                       = {
      resolve_conflicts = "OVERWRITE"
    }
  }
  vpc_id                          = tolist(data.aws_vpcs.vpcs.ids)[0]
  subnet_ids                      = data.aws_subnet_ids.all_subnet.ids
  eks_managed_node_groups         = {
    default                       = {
      launch_template_name        = ""
      source                      = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
      create_launch_template      = false
      name                        = "xd-trial"
      cluster_name                = "xd-trial"
      cluster_version             = "1.22"
      iam_role_attach_cni_policy  = true
      min_size                    = 1
      max_size                    = 10
      desired_size                = 2
      instance_types              = ["t2.small"]
      capacity_type               = "ON_DEMAND"
      tags                        = {
        creator                   = "xd-trial"
        cost                      = "xd-trial"
      }
      subnet_ids                  = data.aws_subnet_ids.private.ids
    }
  }
  tags = {
    creator                       = "xd-trial"
    cost                          = "xd-trial"
  }
}
