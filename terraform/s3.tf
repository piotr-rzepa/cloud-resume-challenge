/*
* AWS S3 configuration (terraform state file storage backend)
*/

resource "aws_s3_bucket" "crc_website" {
  bucket              = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
  force_destroy       = true
  object_lock_enabled = false

  tags = local.tags

}

/*
* AWS S3 configuration (website storage)
*/

resource "aws_s3_bucket_ownership_controls" "crc_ownership" {
  bucket = aws_s3_bucket.crc_website.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_iam_policy_document" "allow_cloudfront_service_principal_read" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.crc_website.arn}/*"]
    effect    = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      values   = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"]
      variable = "AWS:SourceArn"
    }
  }

}

resource "aws_s3_bucket_policy" "allow_cloudfront_service_principal_read" {
  bucket = aws_s3_bucket.crc_website.id
  policy = data.aws_iam_policy_document.allow_cloudfront_service_principal_read.json
}

resource "aws_s3_bucket_public_access_block" "crc_pab_config" {
  bucket = aws_s3_bucket.crc_website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
