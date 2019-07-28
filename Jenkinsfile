node {
    timeout(20){
    try {
        deleteDir() // Clean the workspace
        notifyBuild()
        stage('Checkout') {
            git branch: 'master',
                url: 'https://github.com/swatkiev/finaldocker.git'

        }
        stage('Docker build') {
            dir("site") {
                sh "pwd"
                sh 'docker build -t swatkiev/finaldocker:$DOCKER_TAGS .'
                }
        }
        stage('Docker hub login') {
            sh 'docker login -u $DOCKER_LOGIN -p $DOCKER_PASS'
        }
        stage('Docker push') {
            sh 'docker push swatkiev/finaldocker:$DOCKER_TAGS'
        }
    } catch (e) {
        sh 'exit 1'
        currentBuild.result = "FAILED"
        throw e
        } finally {
        notifyBuild(currentBuild.result)
    }
}
}
def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESS'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESS') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
    summary = "@nick @channel ${subject} (${env.BUILD_URL})"
  }

  // Send notifications
  //slackSend (channel: '#Your Slack channel', color: colorCode, message: summary)
}
