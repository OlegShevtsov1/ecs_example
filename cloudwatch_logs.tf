resource "aws_cloudwatch_log_group" "sample_log_group" {
  name = "/ecs/-${var.r_prefix}"
}
