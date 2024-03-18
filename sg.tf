# Creates Security Group
resource "aws_security_group" "allows_docdb" {
    name = "Roboshop allows traffic from docdb only"
    description = "allow only private traffic"
    vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

 
    ingress {
        description = "SSH from Internet"
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_private_traffic"
    }
}
