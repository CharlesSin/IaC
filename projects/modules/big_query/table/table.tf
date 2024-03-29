resource "google_bigquery_table" "broadcasted_list" {
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"腳本編號\",\"mode\":\"NULLABLE\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"rpa編號\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"description\":\"造訪時間\",\"mode\":\"NULLABLE\",\"name\":\"visited_time\",\"type\":\"DATETIME\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id            = "broadcasted_list"
  deletion_protection = false
}

resource "google_bigquery_table" "dev_broadcasted_list" {
  clustering          = ["scenario_id", "visited_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"腳本編號\",\"mode\":\"NULLABLE\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"rpa編號\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"description\":\"造訪時間\",\"mode\":\"NULLABLE\",\"name\":\"visited_time\",\"type\":\"DATETIME\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id            = "dev_broadcasted_list"
  deletion_protection = false
}

resource "google_bigquery_table" "dev_domain_list" {
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"domain\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"site_name\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"group_domain\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"is_multi\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"DATETIME\"}]"
  table_id            = "dev_domain_list"
  deletion_protection = false

}

resource "google_bigquery_table" "dev_redirect_tracking" {
  clustering          = ["source"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"資料來源\",\"mode\":\"NULLABLE\",\"name\":\"source\",\"type\":\"STRING\"},{\"description\":\"rpa編號\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"使用者編號\",\"mode\":\"NULLABLE\",\"name\":\"user_id\",\"type\":\"STRING\"},{\"description\":\"建立時間\",\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"TIMESTAMP\"},{\"description\":\"utm_source\",\"mode\":\"NULLABLE\",\"name\":\"utm_source\",\"type\":\"STRING\"},{\"description\":\"utm_medium\",\"mode\":\"NULLABLE\",\"name\":\"utm_medium\",\"type\":\"STRING\"},{\"description\":\"utm_campaign\",\"mode\":\"NULLABLE\",\"name\":\"utm_campaign\",\"type\":\"STRING\"},{\"description\":\"utm_term\",\"mode\":\"NULLABLE\",\"name\":\"utm_term\",\"type\":\"STRING\"},{\"description\":\"fb_id\",\"mode\":\"NULLABLE\",\"name\":\"fb_id\",\"type\":\"STRING\"},{\"description\":\"電話號碼\",\"mode\":\"NULLABLE\",\"name\":\"phone\",\"type\":\"STRING\"},{\"description\":\"任務編號\",\"mode\":\"NULLABLE\",\"name\":\"task_id\",\"type\":\"STRING\"},{\"description\":\"remote_ip\",\"mode\":\"NULLABLE\",\"name\":\"remote_ip\",\"type\":\"STRING\"},{\"description\":\"fpid\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"description\":\"encode_id\",\"mode\":\"NULLABLE\",\"name\":\"encode_id\",\"type\":\"STRING\"},{\"description\":\"user_agent\",\"mode\":\"NULLABLE\",\"name\":\"user_agent\",\"type\":\"STRING\"}]"
  table_id            = "dev_redirect_tracking"
  deletion_protection = false

}

resource "google_bigquery_table" "dev_rpa_cookie_info" {
  clustering          = ["domain", "rpa_id", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"REQUIRED\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"網域\",\"mode\":\"REQUIRED\",\"name\":\"domain\",\"type\":\"STRING\"},{\"description\":\"網址\",\"mode\":\"REQUIRED\",\"name\":\"url\",\"type\":\"STRING\"},{\"description\":\"造訪時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"標籤\",\"mode\":\"NULLABLE\",\"name\":\"tag\",\"type\":\"STRING\"},{\"description\":\"轉介網址\",\"mode\":\"NULLABLE\",\"name\":\"referral\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"user_agnet\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"user_agent\",\"type\":\"STRING\"},{\"description\":\"ip\",\"mode\":\"NULLABLE\",\"name\":\"remote_ip\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"jwt\",\"type\":\"STRING\"}]"
  table_id            = "dev_rpa_cookie_info"
  deletion_protection = false


  time_partitioning {
    field = "created_time"
    type  = "DAY"
  }
}

resource "google_bigquery_table" "dev_rpa_user_comparison" {
  clustering          = ["rpa_id", "user_id", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"REQUIRED\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"使用者編號\",\"mode\":\"REQUIRED\",\"name\":\"user_id\",\"type\":\"STRING\"},{\"description\":\"建立時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id            = "dev_rpa_user_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "dev_scenario_task" {
  clustering          = ["scenario_id", "rpa_id", "group_domain", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"腳本任務編號\",\"mode\":\"REQUIRED\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"rpa編號\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"推播父網域\",\"mode\":\"REQUIRED\",\"name\":\"group_domain\",\"type\":\"STRING\"},{\"description\":\"建立時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"標籤\",\"mode\":\"NULLABLE\",\"name\":\"tag\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id            = "dev_scenario_task"
  deletion_protection = false

}

resource "google_bigquery_table" "dev_site_tag_comparison" {
  clustering          = ["site_code", "tag_code"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"tag_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"DATETIME\"}]"
  table_id            = "dev_site_tag_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "dev_site_user_comparison" {
  clustering          = ["fpid", "rpa_id", "user_info"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"description\":\"rpaid\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"網站使用者帳號\",\"mode\":\"NULLABLE\",\"name\":\"user_info\",\"type\":\"STRING\"},{\"description\":\"建立時間\",\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"TIMESTAMP\"}]"
  table_id            = "dev_site_user_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "dev_trace_click_log" {
  clustering          = ["scenario_id", "img_id", "rpa_id", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"description\":\"rpa編號\",\"mode\":\"REQUIRED\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"腳本任務編號\",\"mode\":\"REQUIRED\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"圖片編號\",\"mode\":\"REQUIRED\",\"name\":\"img_id\",\"type\":\"INTEGER\"},{\"description\":\"-1:關閉, 1:前往\",\"mode\":\"REQUIRED\",\"name\":\"click_status\",\"type\":\"INTEGER\"},{\"description\":\"點擊時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"referral\",\"type\":\"STRING\"}]"
  table_id            = "dev_trace_click_log"
  deletion_protection = false

}

resource "google_bigquery_table" "domain_list" {
  clustering          = ["site_code"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"domain\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"site_name\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"group_domain\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"region\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"is_multi\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"TIMESTAMP\"}]"
  table_id            = "domain_list"
  deletion_protection = false

}

resource "google_bigquery_table" "fpid_mapping" {
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid_n\",\"type\":\"STRING\"}]"
  table_id            = "fpid_mapping"
  deletion_protection = false

}

resource "google_bigquery_table" "rpa_cookie_info" {
  clustering          = ["domain", "rpa_id", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"REQUIRED\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"網域\",\"mode\":\"REQUIRED\",\"name\":\"domain\",\"type\":\"STRING\"},{\"description\":\"網址\",\"mode\":\"REQUIRED\",\"name\":\"url\",\"type\":\"STRING\"},{\"description\":\"造訪時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"標籤\",\"mode\":\"NULLABLE\",\"name\":\"tag\",\"type\":\"STRING\"},{\"description\":\"轉介網址\",\"mode\":\"NULLABLE\",\"name\":\"referral\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"user_agent\",\"type\":\"STRING\"},{\"description\":\"ip\",\"mode\":\"NULLABLE\",\"name\":\"remote_ip\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"jwt\",\"type\":\"STRING\"}]"
  table_id            = "rpa_cookie_info"
  deletion_protection = false

  time_partitioning {
    field = "created_time"
    type  = "DAY"
  }
}

resource "google_bigquery_table" "rpa_user_comparison" {
  clustering          = ["rpa_id", "user_id", "created_time"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"user_id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"prefix\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"DATETIME\"}]"
  table_id            = "rpa_user_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "scenario_task" {
  clustering          = ["scenario_id", "rpa_id", "group_domain"]
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

  schema   = "[{\"description\":\"腳本任務編號\",\"mode\":\"REQUIRED\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"rpa編號\",\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"推播父網域\",\"mode\":\"REQUIRED\",\"name\":\"group_domain\",\"type\":\"STRING\"},{\"description\":\"建立時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"標籤\",\"mode\":\"NULLABLE\",\"name\":\"tag\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"}]"
  table_id = "scenario_task"
}

resource "google_bigquery_table" "site_tag_comparison" {
  clustering          = ["site_code", "tag_code"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"tag_code\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"TIMESTAMP\"}]"
  table_id            = "site_tag_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "site_user_comparison" {
  clustering          = ["fpid", "user_info"]
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = "[{\"mode\":\"NULLABLE\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"mode\":\"NULLABLE\",\"name\":\"user_info\",\"type\":\"STRING\"},{\"mode\":\"NULLABLE\",\"name\":\"prefix\",\"type\":\"STRING\"}]"
  table_id            = "site_user_comparison"
  deletion_protection = false
}

resource "google_bigquery_table" "trace_click_log" {
  clustering          = ["scenario_id", "img_id", "created_time", "rpa_id"]
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

  schema   = "[{\"mode\":\"REQUIRED\",\"name\":\"rpa_id\",\"type\":\"STRING\"},{\"description\":\"腳本任務編號\",\"mode\":\"REQUIRED\",\"name\":\"scenario_id\",\"type\":\"INTEGER\"},{\"description\":\"圖片編號\",\"mode\":\"REQUIRED\",\"name\":\"img_id\",\"type\":\"INTEGER\"},{\"description\":\"-1:點擊關閉, 1:點擊前往\",\"mode\":\"REQUIRED\",\"name\":\"click_status\",\"type\":\"INTEGER\"},{\"description\":\"點擊時間\",\"mode\":\"REQUIRED\",\"name\":\"created_time\",\"type\":\"DATETIME\"},{\"description\":\"網站代號\",\"mode\":\"NULLABLE\",\"name\":\"site_code\",\"type\":\"STRING\"},{\"description\":\"數位指紋\",\"mode\":\"NULLABLE\",\"name\":\"fpid\",\"type\":\"STRING\"},{\"description\":\"轉介網址\",\"mode\":\"NULLABLE\",\"name\":\"referral\",\"type\":\"STRING\"}]"
  table_id = "trace_click_log"
}
