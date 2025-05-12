data "aws_iam_policy_document" "admin_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::123456789012:root"] # Replace with trusted account or role
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id] # Optional but recommended for cross-account access
    }
  }
}

resource "aws_iam_role" "snyk-admin-role" {
  name                = "snyk_${var.environment}_role"
  assume_role_policy  = data.aws_iam_policy_document.admin-assume-role-policy.json # (not shown)
  managed_policy_arns = []
}
