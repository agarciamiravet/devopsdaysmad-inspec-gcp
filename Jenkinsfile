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
                           withCredentials([file(credentialsId: 'gcp-credentials', variable: 'gcp-credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'terraform plan -input=false -var=credentials-file=$gcp-credentials -auto-approve'
                           }
                         }
                     }
                 }
                 }
                 stage('Terraform apply') {
                   steps {
                     withCredentials([file(credentialsId: 'gcp-credentials', variable: 'gcp-credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'terraform apply -input=false -var=credentials-file=$gcp-credentials -auto-approve'
                           }
                         }
                 }
                 }
                }
         }
