#!/bin/bash

generate_status=${2}

insert_before_script() {
  echo "
stages:
  - plan
  - apply
default:
  image:
    name: alpine/terragrunt
  tags:
    - gitlab-org-docker
  before_script:
    - unset GOOGLE_APPLICATION_CREDENTIALS
    " >>job.yml
}

insert_dev_sa() {
  echo "    - cp "${DEV_TERRAFORM_SA}" projects/${PROJECT_URL}/terraform_sa.json
  " >>job.yml
}

insert_devqa_sa() {
  echo "    - cp ${PROD_TERRAFORM_SA} projects/${PROJECT_URL}/terraform_sa.json
  " >>job.yml
}

insert_staging_sa() {
  echo "    - cp ${STAGING_TERRAFORM_SA} projects/${PROJECT_URL}/terraform_sa.json
  " >>job.yml
}

insert_prod_sa() {
  echo "    - cp ${PROD_TERRAFORM_SA} projects/${PROJECT_URL}/terraform_sa.json
  " >>job.yml
}

generate_plan_job() {
  PROJECT_URL="$1"
  PARENT_PIPELINE_ID="$2"
  echo "plan:${PROJECT_URL}:
      stage: plan
      script:
        - cd projects/${PROJECT_URL}
        - terragrunt validate
        - terragrunt refresh
        - terragrunt plan -out=tfplan
      artifacts:
        paths:
          - projects/${PROJECT_URL}
        expire_in: \"3600\"
      rules:
        - if: '\$CI_PIPELINE_SOURCE == \"parent_pipeline\"'
  " >>job.yml
}

generate_apply_job() {
  PROJECT_URL="$1"
  PARENT_PIPELINE_ID="$2"
  echo "apply:${PROJECT_URL}:
      stage: apply
      script:
        - cd projects/${PROJECT_URL}
        - echo 'y' | terragrunt apply tfplan
      dependencies:
        - plan:${PROJECT_URL}
      when: manual
  " >>job.yml
}

IFS=',' read -ra PROJECT_URLS <<<"$1"
for PROJECT_URL in "${PROJECT_URLS[@]}"; do
  if [ "${generate_status}" == "dev" ]; then
    echo "環境變數: ${generate_status}"
    insert_before_script
    insert_dev_sa
    generate_plan_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
    generate_apply_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
  fi
  if [ "${generate_status}" == "devqa" ]; then
    echo "環境變數: ${generate_status}"
    insert_before_script
    insert_devqa_sa
    generate_plan_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
    generate_apply_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
  fi
  if [ "${generate_status}" == "staging" ]; then
    echo "環境變數: ${generate_status}"
    insert_before_script
    insert_staging_sa
    generate_plan_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
    generate_apply_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
  fi
  if [ "${generate_status}" == "prod" ]; then
    echo "環境變數: ${generate_status}"
    insert_before_script
    insert_prod_sa
    generate_plan_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
    generate_apply_job "$PROJECT_URL" "$PARENT_PIPELINE_ID"
  fi
done
