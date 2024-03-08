resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  skip_final_snapshot     = true                        # Value will be false in production. In Lab, we will be using true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
}

# Creates DocDB Subnet group
resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}

