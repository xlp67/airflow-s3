resource "aws_glue_catalog_database" "bronze" {
  name = "bronze_db"
}

resource "aws_glue_catalog_database" "silver" {
  name = "silver_db"
}

resource "aws_glue_catalog_database" "gold" {
  name = "gold_db"
}

resource "aws_glue_job" "bronze_to_silver" {
  name     = "bronze_to_silver_job"
  role_arn = var.glue_role_arn
  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${var.script_bucket}/scripts/bronze_to_silver.py"
  }
  default_arguments = {
    "--job-language" = "python"
  }
}

resource "aws_glue_job" "silver_to_gold" {
  name     = "silver_to_gold_job"
  role_arn = var.glue_role_arn
  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${var.script_bucket}/scripts/silver_to_gold.py"
  }
}
