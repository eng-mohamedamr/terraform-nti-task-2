data "aws_availability_zones" "available" {
  state = "available"
}
data "local_file" "bastion_ip" {
  filename = "${path.module}/../modules/instance/bastion_public_ip.txt"
}
module "network" {
  source = "../modules/network"

  vpc_cidr            = var.vpc_cidr
  public_cidr         = var.public_cidr
  private_cidr        = var.private_cidr
  public_subnet_range = var.public_subnet_range
  private_subnet_range = var.private_subnet_range
  az_count            = var.az_count
}
 module "security"{
  source = "../modules/security"
  vpc_id = module.network.vpc_id
  ingress = var.ingress
  egress = var.egress
  public_subnet_ids = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}
module "instance" {
  source = "../modules/instance"
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
  permission     = var.permission
  public_subnet_ids  = module.network.public_subnet_ids
}
module "kubernetes" {
  source = "../modules/k8s"

  instance_public_ip = module.instance.instance_public_ip
}
