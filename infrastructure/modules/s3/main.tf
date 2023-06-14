/*===========================
      AWS S3 resources
============================*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  # acl           = "private"
  force_destroy = true
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership" {
  count = var.public_s3 == true ? 1 : 0
  #  force_destroy = true
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_access" {
  count = var.public_s3 == true ? 1 : 0
  #  force_destroy = true
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  count = var.public_s3 == true ? 1 : 0
  #  force_destroy = true
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_bucket_ownership,
    aws_s3_bucket_public_access_block.s3_bucket_access,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "asset_bucket_policy" {
  count = var.public_s3 == true ? 1 : 0
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_bucket_ownership,
    aws_s3_bucket_public_access_block.s3_bucket_access,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Id      = "BucketPolicy"
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllAccess"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:*"
        ]
        Resource = [
          "${aws_s3_bucket.s3_bucket.arn}",
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
      }
    ]
  })
}
