terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "terraform-cloud-monitoring-state-bucket-test"
    key    = "mattermost-central-command-control-post-installation"
    region = "us-east-1"
  }
  required_providers {
    helm = "~> 0.10"
  }
}


provider "aws" {
  region = var.region
  alias  = "post-deployment"
}


module "cluster-post-installation" {
  source                                       = "../../../../modules/cluster-post-installation"
  environment                                  = var.environment
  deployment_name                              = var.deployment_name
  region                                       = var.region
  tiller_version                               = var.tiller_version
  kubeconfig_dir                               = var.kubeconfig_dir
  db_identifier                                = var.db_identifier
  allocated_db_storage                         = var.allocated_db_storage
  db_engine_version                            = var.db_engine_version
  db_instance_class                            = var.db_instance_class
  db_name                                      = var.db_name
  db_username                                  = var.db_username
  db_password                                  = var.db_password
  db_backup_retention_period                   = var.db_backup_retention_period
  db_backup_window                             = var.db_backup_window
  db_maintenance_window                        = var.db_maintenance_window
  storage_encrypted                            = var.storage_encrypted
  vpc_id                                       = var.vpc_id
  private_subnets                              = var.private_subnets
  mattermost_cloud_image                       = var.mattermost_cloud_image
  mattermost_cloud_ingress                     = var.mattermost_cloud_ingress
  snapshot_identifier                          = var.snapshot_identifier
  mattermost-cloud-namespace                   = var.mattermost-cloud-namespace
  mattermost_cloud_secret_ssh_private          = var.mattermost_cloud_secret_ssh_private
  mattermost_cloud_secret_ssh_public           = var.mattermost_cloud_secret_ssh_public
  mattermost_cloud_secrets_aws_access_key      = var.mattermost_cloud_secrets_aws_access_key
  mattermost_cloud_secrets_aws_secret_key      = var.mattermost_cloud_secrets_aws_secret_key
  mattermost_cloud_secrets_aws_region          = var.mattermost_cloud_secrets_aws_region
  mattermost_cloud_secrets_private_dns         = var.mattermost_cloud_secrets_private_dns
  mattermost_cloud_secrets_keep_filestore_data = var.mattermost_cloud_secrets_keep_filestore_data
  mattermost_cloud_secrets_keep_database_data  = var.mattermost_cloud_secrets_keep_database_data
  provisioner_user                             = var.provisioner_user
  git_url                                      = var.git_url
  git_path                                     = var.git_path
  git_user                                     = var.git_user
  git_email                                    = var.git_email
  ssh_known_hosts                              = var.ssh_known_hosts
  community_hook                               = var.community_hook
  community_channel                            = var.community_channel
  flux_git_url                                 = var.flux_git_url
  validation_acm_zoneid                        = var.validation_acm_zoneid
  domain                                       = var.domain
  cloud_vpn_cidr                               = var.cloud_vpn_cidr


  providers = {
    aws = aws.post-deployment
  }
}

module "customer_web_server" {
  source                         = "../../../../modules/customer-web-server"
  environment                    = var.environment
  cws_name                       = var.cws_name
  region                         = var.region
  deployment_name                = var.deployment_name
  tiller_version                 = var.tiller_version
  kubeconfig_dir                 = var.kubeconfig_dir
  vpc_id                         = var.vpc_id
  private_subnets                = var.private_subnets
  git_image_url                  = var.git_image_url
  git_user                       = var.git_user
  git_email                      = var.git_email
  git_cws_token                  = var.git_cws_token
  cws_db_identifier              = var.cws_db_identifier
  cws_allocated_db_storage       = var.cws_allocated_db_storage
  cws_db_engine_version          = var.cws_db_engine_version
  cws_db_instance_class          = var.cws_db_instance_class
  cws_db_name                    = var.cws_db_name
  cws_db_username                = var.cws_db_username
  cws_db_password                = var.cws_db_password
  cws_db_backup_retention_period = var.cws_db_backup_retention_period
  cws_db_backup_window           = var.cws_db_backup_window
  cws_db_maintenance_window      = var.cws_db_maintenance_window
  cws_storage_encrypted          = var.cws_storage_encrypted
  cws_ingress                    = var.cws_ingress
  mattermost_cws_stripe_key      = var.mattermost_cws_stripe_key
  cws_image_version              = var.cws_image_version
  internal_registry              = var.internal_registry
  pub_domain                     = var.pub_domain
  cloud_vpn_cidr                 = var.cloud_vpn_cidr
}
