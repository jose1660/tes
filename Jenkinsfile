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
    }

    /* #################### Staging #################### */

    stage ('Staging Config') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.STAGING }
      }
      steps {
        input "Continue deployment to Staging?"
        script {
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
    }

    /* #################### Production #################### */

    stage ('Production Config') {
      when {
        allOf { environment name: 'CHANGE_ID', value: ''}
        expression { return params.PRODUCTION }
      }
      steps {
        input "Continue deployment to Production?"
        script {
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
    }
  }
}
