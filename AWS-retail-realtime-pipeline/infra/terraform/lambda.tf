resource "aws_lambda_function" "kafka_consumer" {
  function_name = "${var.project_prefix}-kafka-consumer"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_kafka_consumer.lambda_handler"
  runtime       = "python3.11"

  filename         = "build/lambda_kafka_consumer.zip" # you package this
  source_code_hash = filebase64sha256("build/lambda_kafka_consumer.zip")

  environment {
    variables = {
      BRONZE_BUCKET = aws_s3_bucket.bronze.bucket
    }
  }
}
