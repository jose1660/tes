pipeline {
  agent any
  stages {
    stage('Inicio') {
      steps {
        sh 'echo "hola"'
      }
    }
    stage('Build') {
      steps {
        sh '''echo "build"

hubotSend message: "*Release Completed*. \\n Releaseing Test Project.", tokens: "BUILD_NUMBER,BUILD_ID", status: \'SUCCESS\'
'''
      }
    }
    stage('aprobaciÃƒÂ³n') {
      steps {
        sh '''hubotApprove message: \'Promote to Staging?\', tokens: "BUILD_NUMBER, BUILD_DURATION", status: \'ABORTED\'
'''
      }
    }
    stage('inicio pre') {
      steps {
        sh '''hubotSend message: "*Staging Deployment Successful...* \\n Deployed Test Project to 192.168.1.175 node.", tokens: "BUILD_NUMBER,BUILD_ID", status: \'SUCCESS\'
'''
      }
    }
    stage('test') {
      steps {
        sh 'echo "test"'
      }
    }
    stage('a prod?') {
      steps {
        sh '''hubotApprove message: \'Promote to Production?\', tokens: "BUILD_NUMBER, BUILD_DURATION", status: \'ABORTED\'
'''
      }
    }
    stage('fin') {
      steps {
        sh 'hubotSend message: "*Hooray! Went to Prod... :satisfied:* \\n Deployed Test Project to prod(10.12.1.191) node.", tokens: "BUILD_NUMBER,BUILD_ID", status: \'SUCCESS\''
      }
    }
  }
}