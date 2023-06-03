module "network_config" {
  source = "../terraform-modules/eks_network"

  vpc_cidr          = var.vpc_cidr
  enable_vpc_dns    = var.enable_vpc_dns
  subnet_count      = var.subnet_count
  subnet_bits       = var.subnet_bits
  project_name      = var.project_name
  env               = var.env
}

module "cluster_config" {
  source = "../terraform-modules/eks_cluster"

  k8s_version           = var.k8s_version
  public_subnets_ids    = module.network_config.public_subnet_ids
  private_subnets_ids   = module.network_config.private_subnet_ids
  project_name          = var.project_name
  env                   = var.env

  depends_on = [module.network_config]
}

module "nodes_config" {
  source = "../terraform-modules/eks_node_group"

  cluster_name          = module.cluster_config.eks_cluster_name
  k8s_version           = var.k8s_version
  instance_type         = var.instance_type
  desired_node_count    = var.desired_node_count
  min_node_count        = var.min_node_count
  max_node_count        = var.max_node_count
  node_disk_size        = var.node_disk_size
  ami_type              = var.ami_type
  capacity_type         = var.capacity_type
  private_subnets_id    = module.network_config.private_subnet_ids
  project_name          = var.project_name
  env                   = var.env

  depends_on = [module.cluster_config]
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.cluster_config.eks_cluster_name}"
  }

  depends_on = [module.nodes_config]
}