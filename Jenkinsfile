pipeline {
         agent any
         stages {
                 stage('Terraform init') {
                 steps {
                   
                         withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                                  sh '''
                                        export  GOOGLE_APPLICATION_CREDENTIALS=$gcp_credentials
                                        export  GOOGLE_CLOUD_KEYFILE_JSON=$gcp_credentials
                                        terraform init -input=false                                        
                                    '''
                           }
                         } 
                 }
                 }
                 stage('Terraform plan') {
                  steps {
                    dir("${env.WORKSPACE}/src/terraform"){
                           withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh '''
                                    export  GOOGLE_APPLICATION_CREDENTIALS=$gcp_credentials
                                    export  GOOGLE_CLOUD_KEYFILE_JSON=$gcp_credentials
                                    terraform plan -input=false -var=credentials_file=$gcp_credentials
                              '''
                           }
                         }
                     }
                 }
                 }
                 stage('Terraform apply') {
                   steps {
                     withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'''
                                  export  GOOGLE_APPLICATION_CREDENTIALS=$gcp_credentials
                                  export  GOOGLE_CLOUD_KEYFILE_JSON=$gcp_credentials
                                  terraform apply -input=false -var=credentials_file=$gcp_credentials -auto-approve
                              '''
                           }
                         }
                 }
                 }
                 stage ('Inspec tests') {
                   steps {
                           withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-gcp"){
                              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                              sh '''
                                  export GOOGLE_APPLICATION_CREDENTIALS=$gcp_credentials
                                  inspec exec . --chef-license=accept --input-file attributes.yaml --reporter cli junit:testresults.xml json:output.json --no-create-lockfile -t gcp://
                              '''
                              }
                           }
                         }                     
                   }
                 }
                  stage('Upload tests to grafana') {
                        steps {
                             dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-gcp"){                                   
                                   sh '''
                                        ls
                                        curl -F 'file=@output.json' -F 'platform=gcp-terraform' http://localhost:5001/api/InspecResults/Upload
                                   '''                                   
                           }                      
                        }
                    }

                  stage('Infra delete') {
                   steps {
                     withCredentials([file(credentialsId: 'gcp_credentials', variable: 'gcp_credentials')]) {
                            dir("${env.WORKSPACE}/src/terraform"){
                              sh'''
                                  export  GOOGLE_APPLICATION_CREDENTIALS=$gcp_credentials
                                  export  GOOGLE_CLOUD_KEYFILE_JSON=$gcp_credentials
                                  terraform destroy -input=false -var=credentials_file=$gcp_credentials -auto-approve
                              '''
                           }
                         }
                 }
                 }
                }
               post {
                      always {
                                junit '**/src/inspec/devopsdaysmad-gcp/*.xml'
                             }
               }
}
