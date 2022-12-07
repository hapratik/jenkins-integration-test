pipeline {
    agent any
    //test
    stages{
        stage('SCM'){
            git 'https://github.com/hapratik/jenkins-integration-test'
        }
        
        stage('compile'){
        def mvnHome = tool name: 'maven', type: 'maven'}
        sh "$({mvnHome}/bin/mvn package)"
        }//stage
    
        stage('sonar_scan') {
            def mvnHome = tool name: 'maven-3', type: 'maven'
                withSonarQubeEnv('jenkins-pipeline') {
                    sh "${mvnHome/bin/mvn sonar:sonar}"
                }
        }//stage
    }//stages



}//pipeline

