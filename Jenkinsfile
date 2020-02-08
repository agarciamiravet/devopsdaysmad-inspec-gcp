pipeline {
         agent any
         stages {
                 stage('Terraform init') {
                 steps {
                          dir("${env.WORKSPACE}/src/terraform"){
                               sh "terraform init -input=false"
                           }
                 }
                 }
                 stage('Terraform plan') {
                  steps {
                    dir("${env.WORKSPACE}/src/terraform"){
                           withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'terraform plan -input=false -var=credentials_file=$gcp_credentials'
                           }
                         }
                     }
                 }
                 }
                 stage('Terraform apply') {
                   steps {
                     withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'terraform apply -input=false -var=credentials_file=$gcp_credentials -auto-approve'
                           }
                         }
                 }
                 }
                }
         }
