pipeline {
  agent any
  stages {
    stage('Inicio') {
      steps {
        sh '''echo "hola"
hubotSend message: "*Release Started*. \\n Releasing Test Project. :sunny: \\n room: \'pull-request\' <@nrayapati> ", tokens: "BUILD_NUMBER,BUILD_ID", status: \'STARTED\'
'''
      }
    }
    stage('Build') {
      steps {
        sh '''echo "build"

hubotSend message: "*Release Completed*. \\n Releaseing Test Project.", tokens: "BUILD_NUMBER,BUILD_ID", status: \'SUCCESS\'
'''
      }
    }
    stage('aprobaciÃ³n') {
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