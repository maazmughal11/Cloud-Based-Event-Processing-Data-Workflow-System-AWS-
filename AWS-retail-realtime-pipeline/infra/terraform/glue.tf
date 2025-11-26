resource "aws_glue_job" "bronze_to_silver" {
  name     = "${var.project_prefix}-bronze-to-silver"
  role_arn = aws_iam_role.glue_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.project_prefix}-scripts/etl/glue_bronze_to_silver.py"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"    = "${var.project_prefix}-bronze-to-silver"
    "--BRONZE_PATH" = "s3://${aws_s3_bucket.bronze.bucket}/"
    "--SILVER_PATH" = "s3://${aws_s3_bucket.silver.bucket}/"
  }

  glue_version = "4.0"
}

resource "aws_glue_job" "silver_to_gold" {
  name     = "${var.project_prefix}-silver-to-gold"
  role_arn = aws_iam_role.glue_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.project_prefix}-scripts/etl/glue_silver_to_gold.py"
    python_version  = "3"
  }

  default_arguments = {
    "--JOB_NAME"    = "${var.project_prefix}-silver-to-gold"
    "--SILVER_PATH" = "s3://${aws_s3_bucket.silver.bucket}/"
    "--GOLD_PATH"   = "s3://${aws_s3_bucket.gold.bucket}/"
  }

  glue_version = "4.0"
}
