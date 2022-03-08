resource "aws_iam_openid_connect_provider" "default" {
  url = "https://oidc.eks.us-east-2.amazonaws.com/id/D9BF1AB3347B2315CB103BF013D6DAA6"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}
