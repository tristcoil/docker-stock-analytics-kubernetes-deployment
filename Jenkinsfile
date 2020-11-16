pipeline {
     agent any
     stages {

         stage('Linting') {
             steps {
                    sh 'python3 -m venv venv'
                    sh '. venv/bin/activate'
                    sh 'sudo make install'

                    sh 'sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64'
                    sh 'sudo chmod +x /bin/hadolint'
                    sh 'make lint'
              }
             }




         stage('Build Docker Image') {
             steps {
                    sh 'sudo ./build_docker.sh'
              }
             }

         stage('Upload docker image to DockerHub') {
             steps {

                  withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                  //accessible via $user and $pass calls
                  sh 'echo $user'
                  sh 'sudo ./upload_docker_jenkins.sh $user $pass'
               }
              }
             }


         stage('Associate with cluster') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                        sh 'aws eks --region us-east-2 update-kubeconfig --name analytics-cluster'
                        sh 'kubectl get svc'

               }
              }
             }

// removing deployment changes LB address
//         stage('Delete previous deployment') {
//             steps {
//                    withAWS(credentials:'aws-kubernetes') {
//                        sh 'kubectl delete -f deployment-config.yaml'
//                        sh 'kubectl get all -n stock-app'
//               }
//              }
//             }


         stage('Deploy app to k8s and check namespace') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                        sh 'kubectl apply -f deployment-config.yaml'
                        sh 'sleep 60'
                        sh 'kubectl get all -n stock-app'
               }
              }
             }

         stage('Verify LB address') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                        sh 'sleep 60'
                        sh 'kubectl get ingress/ingress-stock-app -n stock-app'
               }
              }
             }


         stage('Clean-up docker images') {
             steps {
                    sh 'df -h'
                    sh 'sudo docker system prune -f -a'
                    sh 'df -h'
              }
             }




         }
     }
