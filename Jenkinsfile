pipeline {
         agent any
         stages {
                 stage('Terraform Init') {
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
                 stage('Terraform Plan') {
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
                 stage('Terraform Apply') {
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
                 stage ('Inspec Infrastructure Tests') {
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
                  stage('Upload Tests to Grafana') {
                        steps {
                             dir("${env.WORKSPACE}/src/inspec/devopsdaysmad-gcp"){                                   
                                   sh '''
                                        ls
                                        curl -F 'file=@output.json' -F 'platform=gcp-terraform' http://localhost:5001/api/InspecResults/Upload
                                   '''                                   
                           }                      
                        }
                    }

                  stage('Destroy Infrastructure') {
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
