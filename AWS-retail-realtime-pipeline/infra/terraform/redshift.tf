resource "aws_redshift_cluster" "retail_cluster" {
  cluster_identifier = "${var.project_prefix}-redshift"
  node_type          = "dc2.large"
  number_of_nodes    = 1

  master_username = "adminuser"
  master_password = "ChangeMe123!"

  publicly_accessible = true
  skip_final_snapshot = true
}
