variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
  default     = null
}

variable "s3_force_destroy" {
  description = "Set to true if all objects should be deleted from the bucket, so that the bucket can be destoryed without errors."
  type        = bool

}
variable "s3_object_lock_enabled" {
  description = "Set to true to enable Object Lock configuration on a S3 Bucket"
  type        = bool

}
variable "s3_attach_deny_insecure_transport_policy" {
  description = "Set to true to make S3 bucket policy deny non-SSL transport policy"
  type        = bool

}
variable "s3_attach_deny_incorrect_encryption_headers" {
  description = "Set to true to make S3 bucket policy deny incorrect encryption headers policy"
  type        = bool

}
variable "s3_attach_deny_incorrect_kms_key_sse" {
  description = "Set to true to make S3 bucket policy deny usage of uncorreect KMS key SSE"
  type        = bool

}
variable "s3_block_public_acls" {
  description = "Set to true to make Amazon3 block public ACLs for this bucket"
  type        = bool

}
variable "s3_block_public_policy" {
  description = "Set to true to make Amazon3 block public bucket policies for this bucket"
  type        = bool

}
variable "s3_restrict_public_buckets" {
  description = "Set to true to make Amazon S3 restrict public bucket policies for this bucket"
  type        = bool

}
variable "s3_ignore_public_acls" {
  description = "Set to true to make Amazon S3 ignore public ACLs for this bucket"
  type        = bool

}

variable "cf_description" {
  description = "Comments about given distribution"
  type        = string
  default     = ""
}

variable "cf_price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string

  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.cf_price_class)
    error_message = "The value for price class must be one of PriceClass_All, PriceClass_200, PriceClass_100"
  }
}

variable "cf_http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2"
  type        = string

  validation {
    condition     = contains(["http1.1", "http2", "http2and3", "http3"], var.cf_http_version)
    error_message = "Allowed values are http1.1, http2, http2and3, and http3. The default is http2"
  }
}

variable "cf_is_ipv6_enabled" {
  description = "Set to true to enable IPv6 for the distribution"
  type        = bool

}

variable "cf_default_root_object" {
  description = "The object that you want CloudFront to return when an end user requests the root URL"
  type        = string
  default     = "index.html"

}

variable "cf_create_oac" {
  description = "Set to true to create CloudFront Origin Access Control"
  type        = bool
}

variable "cf_oac_description" {
  description = "Description of Origin Access Control for the Distribution"
  type        = string
  default     = ""
}

variable "cf_oac_origin_type" {
  description = "Type of the Origin for Origin Access Control"
  type        = string
}

variable "cf_oac_signinig_behavior" {
  description = "Wheter CloudFront should sign each request"
  type        = string
}

variable "cf_oac_signinig_protocol" {
  description = "What protocol to use for CloudFront to sign the requestes"
  type        = string
}

variable "cf_cache_allowed_methods" {
  description = "List of HTTP methods allowed by ths distribution"
  type        = list(string)
}

variable "cf_cache_cached_methods" {
  description = "List of cachable HTTP methods by this distirbution"
  type        = list(string)
}

variable "cf_cache_viewer_protocol_policy" {
  description = "How to handle HTTP and HTTPS request to CloudFront"
  type        = string

  validation {
    condition     = contains(["redirect-to-https", "allow-all", "https-only"], var.cf_cache_viewer_protocol_policy)
    error_message = "A viewer protocol policy must be one of redirect-to-https, allow-all, https-only"
  }
}

variable "cf_cache_response_headers_policy_id" {
  description = "The ID of AWS managed cache policy for CloudFront, which adds or removes headers in responses to viewers"
  type        = string
}
