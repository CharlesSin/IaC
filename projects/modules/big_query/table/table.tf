resource "google_bigquery_table" "broadcasted_list" {
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"腳本編號\",\"mode\":\"NULLABLE\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"編號\",\"mode\":\"NULLABLE\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"description\":\"造訪時間\",\"mode\":\"NULLABLE\",\"name\":\"visited_time\",\"type\":\"DATETIME\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id            = "broadcasted_list"
  deletion_protection = false
}
resource "google_bigquery_table" "trace_click_log" {
  clustering          = ["scenario_id", "img_id", "created_time", "id"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  deletion_protection = false

  range_partitioning {
    field = "scenario_id"

    range {
      end      = 500000000
      interval = 100000
      start    = 200000000
    }
  }

  schema   = "[{\"mode\":\"REQUIRED\",\"name\":\"id\",\"type\":\"STRING\"},{\"description\":\"腳本任務編號\",\"mode\":\"REQUIRED\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"圖片編號\",\"mode\":\"REQUIRED\",\"name\":\"img_id\",\"type\":\"INTEGER\"},{\"description\":\"-1:點擊關閉, 1:點擊前往\",\"mode\":\"REQUIRED\",\"name\":\"click_status\",\"type\":\"INTEGER\"},{\"description\":\"點擊時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"description\":\"轉介網址\",\"mode\":\"NULLABLE\",\"name\":\"referral\",\"type\":\"STRING\"}]"
  table_id = "trace_click_log"
}
