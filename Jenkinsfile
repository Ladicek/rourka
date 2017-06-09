node("launchpad-maven") {
  stage("Checkout") {
    checkout scm
  }

  stage("Build and deploy") {
    sh "mvn clean fabric8:deploy"
  }
}
