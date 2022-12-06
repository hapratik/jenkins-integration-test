pipeline {
             
  agent any
    
  environment {
    AWS_ACCOUNT_ID="867610719927"
    AWS_DEFAULT_REGION="ap-south-1"
    IMAGE_REPO_NAME="nest-auth"
    IMAGE_TAG="v1.0.1"
  }

  stages {
           
    // stage('build && SonarQube analysis') {
          
    //         steps {
            
    //                  script{
                         
    //                      def scannerHome = tool 'SonarScanner';
    //                withSonarQubeEnv(credentialsId: 'sonarqube-id') {
                 
    //                    sh "${tool('SonarScanner')}/bin/sonar-scanner -X -Dsonar.java.binaries=target/classes -Dsonar.projectName=${env.JOB_NAME} -Dsonar.java.binaries=. -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=${env.JOB_BASE_NAME} " 
    //             }
    //         }
    //     }
        
    // }
      stage('docker build') {
        steps {
            script{
                // sh 'docker build -t nest-ionic:latest .'
                dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }
        }
      }
          
        stage('Logging into AWS ECR') {
          steps {
              script {
              sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
              }
                
          }
    }

    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
                sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
         }
        }
      }


  }
}


