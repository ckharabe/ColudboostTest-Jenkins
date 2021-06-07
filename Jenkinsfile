pipeline {

  agent any
  options { timestamps() }
  
  
   stages{
    stage('checkout') {
      steps {
        checkout scm
        
        script {
            withCredentials([usernamePassword(credentialsId: 'az-devops-token', passwordVariable: 'GIT_PASSWORD',usernameVariable: 'GIT_USERNAME')]){
              sh 'git submodule update --init'
            }
          }
        }
      }
    }
  
      stage ('init plan apply') {
      steps {
        script {
          withEnv([
            "GIT_ASKPASS=${WORKSPACE}/askpass.sh"]){
            withCredentials([usernamePassword(credentialsId: "${env.AZ_DEVOPS_TOKEN}", 
                                            passwordVariable: 'GIT_PASSWORD',
                                            usernameVariable: 'GIT_USERNAME')]){
              
        stage ('init plan apply') {
      steps {      
              "terraform init
      }
