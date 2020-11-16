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



         stage('Associate with cluster') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                        sh 'aws eks --region us-east-2 update-kubeconfig --name analytics-cluster'
                        sh 'kubectl get svc'

               }
              }
             }

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
                        sh 'kubectl get ingress/ingress-stock-app -n stock-app'
               }
              }
             }



/*
         stage('LB Role and service account creation') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                    sh '''
                          eksctl create iamserviceaccount \
                               --cluster=analytics-cluster \
                               --namespace=kube-system \
                               --region us-east-2 \
                               --name=aws-load-balancer-controller \
                               --attach-policy-arn=arn:aws:iam::667684686916:policy/AWSLoadBalancerControllerIAMPolicy \
                               --override-existing-serviceaccounts \
                               --approve \
                       '''
               }
              }
             }

         stage('LB controller installation') {
             steps {
                    withAWS(region:'us-east-2', credentials:'aws-kubernetes') {
                    sh 'kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"'

                    sh 'helm repo add eks https://aws.github.io/eks-charts'

                    sh '''
                          helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
                              --set clusterName=analytics-cluster \
                              --set serviceAccount.create=false \
                              --set serviceAccount.name=aws-load-balancer-controller \
                              -n kube-system \
                       '''

                    sh 'kubectl get deployment -n kube-system aws-load-balancer-controller'
               }
              }
             }

*/

         stage('Clean-up docker images') {
             steps {
                    sh 'df -h'
                    sh 'sudo docker system prune -f -a'
                    sh 'df -h'
              }
             }




         }
     }
