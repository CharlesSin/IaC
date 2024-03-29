# modules
module "instance" {
  source        = "./instance"
  project_id    = var.project_id
  region        = var.region
  services      = var.services
  vpc_connector = var.vpc_connector
}

module "role" {
  source             = "./role"
  cloud_run_name     = module.instance.cloud_run_service_name
  cloud_run_location = var.region
}
