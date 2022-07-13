pipeline {
    agent any
    environment {
        registry = "201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment"
    }

    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], url: 'https://github.com/RisathR/New-Assignment.git']]])
            }
        }

    stage('Building image') {
      steps{
        script {
          def dockerHome = tool 'docker'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
          dockerImage = docker.build registry
        }
      }
    }

    stage('Pushing to ECR') {
        steps{
            script {
                sh 'docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment '
                sh 'docker push 201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment'
            }
        }
    }

    stage('Docker Deploy') {
     steps{
         script {
             sshagent(credentials : ['apachetest']){
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@10.0.2.228 "docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment && docker pull 201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment && (docker ps -f name=node -q | xargs --no-run-if-empty docker container stop) && (docker container ls -a -fname=node -q | xargs -r docker container rm) && docker run -d -p 8081:8081 --rm --name node 201733685594.dkr.ecr.us-east-1.amazonaws.com/assignment"'

             }


            }
      }
    }
    }
}
