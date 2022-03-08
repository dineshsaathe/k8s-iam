resource "aws_iam_role" "list_s3" {
  name = "s3-list-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::095304171175:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/D9BF1AB3347B2315CB103BF013D6DAA6"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.us-east-2.amazonaws.com/id/D9BF1AB3347B2315CB103BF013D6DAA6:sub": "system:serviceaccount:qa:my-qa"
                }
            }
        }
    ]
})
}

resource "aws_iam_policy" "s3_list" {
  name        = "s3_list_all"
  description = "allows listing all s3 buckets"
  policy      = file("role_permissions_policy.json")
}

resource "aws_iam_policy_attachment" "s3_list" {
  name       = "list s3 buckets policy to role"
  roles      = ["${aws_iam_role.list_s3.name}"]
  policy_arn = aws_iam_policy.s3_list.arn
}
