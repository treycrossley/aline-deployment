data "tls_certificate" "eks-tc" {
  url = var.cluster_oidc_issuer
}

resource "aws_iam_openid_connect_provider" "eks-provider-tc" {
  client_id_list  = var.client_id_list
  thumbprint_list = [data.tls_certificate.eks-tc.certificates[0].sha1_fingerprint]
  url             = var.cluster_oidc_issuer
}
