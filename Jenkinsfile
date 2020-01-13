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
                               sh "terraform plan -input=false"
                           }
                 }
                 }
                 stage('Terraform apply') {
                   steps {
                      dir("${env.WORKSPACE}/src/terraform"){
                               sh "terraform apply -input=false -auto-approve"
                           }
                         }
                 }
                  stage('Terraform destroy') {
                   steps {
                      dir("${env.WORKSPACE}/src/terraform"){
                               sh "terraform destroy -input=false -auto-approve"
                           }
                         }
                 }
                }
         }
