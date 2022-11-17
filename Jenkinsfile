
pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="726754545968"
        AWS_DEFAULT_REGION="ap-south-1" 
        IMAGE_REPO_NAME="content-moderation"
        IMAGE_TAG="IMAGE_TAG"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
        stage('login into aws'){
            
            steps{
                withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', 
                credentialsId: 'aws-ecr', 
                accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
                {
                sh 'echo $AWS_ACCESS_KEY_ID'
                sh 'aws ec2 describe-volumes'
            }
      
            
            }
        }
        
        stage('checkout gitscm') {
            steps {
                script {
                 git branch: 'main', credentialsId: 'jenkins-now', url: 'https://github.com/hapratik/jenkins-integration-test.git'
                }
                 
            }
        }
        stage('SonarQube analysis') {
             steps{
   def scannerHome = tool 'SonarScanner';
    withSonarQubeEnv('sonarqube') {
      sh "${scannerHome}/bin/sonar-scanner"
      sh "${scannerHome}/bin/sonar-scanner \
      -D sonar.login=admin \
      -D sonar.password=Onclick@1234\
      -D sonar.projectKey=ai-engine \
      -D sonar.exclusions=vendor/**,resources/**,**/*.java \
      -D sonar.host.url=http:http://3.108.42.112:8080/"
    }
             }
  }
        
         stage('Logging into AWS ECR') {
            steps {
                script {
               
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION}|docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        
         
        
       
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
         }
        }
      }
    }
}


