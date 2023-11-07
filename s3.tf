resource "aws_s3_bucket" "sample_alb_logs" {
  bucket = "${var.r_prefix}-${var.aws_namespace}-alb-logs"
}
