terraform {
  source = "../modules/redis_instance"
}

inputs = {
  project_id         = ""
  region             = ""
  zone               = ""
  network           = ""
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
