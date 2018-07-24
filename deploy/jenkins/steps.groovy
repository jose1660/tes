def deploy(def config) {
    echo 'make install'
    echo 'make build-latest'
    //sh 'make migrate'
    //sh 'make publish'
    //sh 'make update-service'
}

def rollback(def config) {
    echo 'make install'
    echo 'make rollback'
}

def registry(def config) {
    echo 'make create-registry'
}

def configs(def enviroment) {
  def config = [
    "ENV=${enviroment}",
    "INFRA_BUCKET=infraestructura.${enviroment}"
  ]

  return config
}

return this
