#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "eks_cluster_role" {
  name = "terraform-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "terraform-eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.myVPC.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-cluster"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster_sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  version = var.kubernetes_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
    subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_vpc.myVPC,
    aws_subnet.private_subnet_1,
    aws_subnet.private_subnet_2,
    aws_subnet.private_subnet_3,
    aws_subnet.private_subnet_4
  ]
}

########## Addons required for K8s ################


resource "aws_eks_addon" "k8s_addons_1" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "k8s_addons_2" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "k8s_addons_3" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}