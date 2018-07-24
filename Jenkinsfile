#!/usr/bin/env groovy

def fnSteps = evaluate readTrusted("deploy/jenkins/steps.groovy")

pipeline {
  agent any
  environment {
    DEVELOPMENT_ENV = 'dev'
    STAGING_ENV = 'pre'
    PRODUCTION_ENV = 'prod'
  }
  parameters {
    booleanParam(name: 'DEVELOPMENT', defaultValue: true, description: "Ejecutar Development")
    booleanParam(name: 'STAGING', defaultValue: true, description: "Ejecutar Staging")
    booleanParam(name: 'PRODUCTION', defaultValue: true, description: "Ejecutar Production")
    choice(
      name: 'EXECUTE',
      choices:"DEPLOY\nROLLBACK\nREGISTRY",
      description: '''DEPLOY: Se realiza deploy del servicio
ROLLBACK: Rollback de la Ãºltima migraciÃ³n
REGISTRY: Requiere construir o no Registry en ECR'''
    )
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Tests') {
      steps {
        echo 'make test-project'
      }
    }

    /* #################### Development #################### */

    stage('Development Config') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.DEVELOPMENT }
      }
      steps {
        script {
          config = fnSteps.configs(DEVELOPMENT_ENV)
          withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
          hubotSend message: "*Release Started*. \n Releasing Test Project. :sunny: \n<!here> <!channel> <@nrayapati> ", tokens: "BUILD_NUMBER,BUILD_ID", status: 'STARTED'
        }
      }
    }
    stage('Development') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.DEVELOPMENT }
      }
      parallel {
        stage('Deploy') {
          when { expression { return params.EXECUTE == 'DEPLOY' }}
          steps { script { fnSteps.deploy(config) } }
        }
        stage('Rollback') {
          when { expression { return params.EXECUTE == 'ROLLBACK' }}
          steps { script { fnSteps.rollback(config) } }
        }
        stage('ECR') {
          when { expression { return params.EXECUTE == 'REGISTRY' }}
          steps { script { fnSteps.registry(config) } }
        }
      }
      post {
        success {
          script {
            withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
            hubotSend message: "*Release Completed*. \n Releaseing Test Project.", tokens: "BUILD_NUMBER,BUILD_ID", status: 'SUCCESS'
          }
        }
      }

    }

    /* #################### Staging #################### */

    stage ('Staging Config') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.STAGING }
      }
      steps {
        //input "Continue deployment to Staging?"
        script {
          withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
          hubotApprove message: 'Promote to Staging?', tokens: "BUILD_NUMBER, BUILD_DURATION", status: 'ABORTED'
          config = fnSteps.configs(DEVELOPMENT_ENV)
        }
      }
    }

    stage('Staging') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.STAGING }
      }
      parallel {
        stage('Deploy') {
          when { expression { return params.EXECUTE == 'DEPLOY' }}
          steps { script { fnSteps.deploy(config) } }
        }
        stage('Rollback') {
          when { expression { return params.EXECUTE == 'ROLLBACK' }}
          steps { script { fnSteps.rollback(config) } }
        }
        stage('ECR') {
          when { expression { return params.EXECUTE == 'REGISTRY' }}
          steps { script { fnSteps.registry(config) } }
        }
      }
      post {
        success {
          script {
            withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
            hubotSend message: "*Staging Deployment Successful...* \n Deployed Test Project to 192.168.1.175 node.", tokens: "BUILD_NUMBER,BUILD_ID", status: 'SUCCESS'
          }
        }
      }
    }

    /* #################### Production #################### */

    stage ('Production Config') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.PRODUCTION }
      }
      steps {
        //input "Continue deployment to Production?"
        script {
          withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
          hubotApprove message: 'Promote to Production?', tokens: "BUILD_NUMBER, BUILD_DURATION", status: 'ABORTED'
          config = fnSteps.configs(DEVELOPMENT_ENV)
        }
      }
    }

    stage('Production') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.PRODUCTION }
      }
      parallel {
        stage('Deploy') {
          when { expression { return params.EXECUTE == 'DEPLOY' }}
          steps { script { fnSteps.deploy(config) } }
        }
        stage('Rollback') {
          when { expression { return params.EXECUTE == 'ROLLBACK' }}
          steps { script { fnSteps.rollback(config) } }
        }
        stage('ECR') {
          when { expression { return params.EXECUTE == 'REGISTRY' }}
          steps { script { fnSteps.registry(config) } }
        }
      }
      post {
        success {
          script {
            withEnv(['HUBOT_URL=http://52.2.27.172:9999','HUBOT_DEFAULT_ROOM=pull-requests','HUBOT_FAIL_ON_ERROR=false'])
            hubotSend message: "*Hooray! Went to Prod... :satisfied:* \n Deployed Test Project to prod(10.12.1.191) node.", tokens: "BUILD_NUMBER,BUILD_ID", status: 'SUCCESS'
          }
        }
      }
    }
  }
}
