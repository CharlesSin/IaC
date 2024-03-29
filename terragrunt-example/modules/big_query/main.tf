# modules
module "dataset" {
  source = "./dataset"
}

module "table" {
  source     = "./table"
  project_id = var.project_id
  webpush_id = module.dataset.webpush_dataset_id
}
