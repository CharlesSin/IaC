terraform {
  source = "../../modules/redis_instance"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_redis_instance_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_redis_instance_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_redis_instance_terraform.tfstate/lock"

    username = ""
    password = ""

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount     = "terraform_sa.json"
  project_id         = ""
  region             = ""
  zone               = ""
  network            = ""
  name               = "redis-instance"
  network_project_id = ""
  display_name       = "redis-instance"
  tier               = "BASIC"
  memory_size_gb     = 1
  replica_count      = 2
  read_replicas_mode = "READ_REPLICAS_ENABLED"
  connect_mode       = "PRIVATE_SERVICE_ACCESS"
  auth_enabled       = false
  redis_version      = "REDIS_7_0"
  labels             = {}
  maintenance_policy = {
    day = "TUESDAY" // 週三早上 6 點 - 7 點 (UTC+8)
    start_time = {
      hours   = 22
      minutes = 0
      seconds = 0
      nanos   = 0
    }
  }
  redis_configs = {
    "maxmemory-policy" = "volatile-lru"
  }

}


