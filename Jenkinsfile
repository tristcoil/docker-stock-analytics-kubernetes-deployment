pipeline {
     agent any
     stages {


         stage('Build Docker Image') {
             steps {  
                    sh './build_docker.sh'
              }
             }



/*

         stage('LB IAM OIDC provider and cluster pairing') {
             steps {
                    withAWS(credentials:'aws-kubernetes') {
                    sh '''
                          eksctl utils associate-iam-oidc-provider \
                               --region us-east-2 \
                               --cluster analytics-cluster \
                               --approve \
                      '''                   
               }     
              }
             }


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






         }
     }
