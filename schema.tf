# Injecting the Schema
resource "null_resource" "schema" {
    depends_on = [ aws_docdb_cluster.docdb , aws_docdb_cluster_instance.cluster_instances ]
    provisioner "local-exec" {
        command = <<EOF
            wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
            curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
            cd /tmp
            unzip -o /tmp/mongodb.zip
            cd mongodb-main
            ls -ltr
            mongodb://admin1:roboshop1@${aws_docdb_cluster.docdb.endpoint}/?tls=true&tlsCAFile=global-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false  < catalogue.js
             
        EOF
    }
}

# mongo --tls --host ${aws_docdb_cluster.docdb.endpoint} --tlsCAFile global-bundle.pem --username admin1 --password roboshop1 < users.js   