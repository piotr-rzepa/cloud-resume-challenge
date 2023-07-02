data "aws_iam_policy_document" "bucket_policy_cloudfront" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${module.s3-bucket.s3_bucket_arn}/*"]
    effect    = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      values   = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${module.cloudfront.cloudfront_distribution_id}"]
      variable = "AWS:SourceArn"
    }
  }
}
