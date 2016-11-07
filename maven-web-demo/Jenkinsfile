node {
    stage('SCM') {
        git 'https://github.com/lfsoftware13/TestJenkins.git'
    }
    stage('QA') {
        sh 'pwd'
        sh 'echo $PATH'
        sh 'echo $SHELL'
        sh 'sonar-scanner'
    }
    stage('build') {
        def mvnHome = tool 'M3'
        sh 'pwd'
        sh "cd maven-web-demo/;${mvnHome}/bin/mvn -B clean package"
    }
    stage('deploy') {
        sh "docker stop my || true"
        sh "docker rm my || true"
        sh "docker run --name my -p 11111:8080 -d tomcat"
        sh "docker cp target/maven-web-demo.war my:/usr/local/tomcat/webapps"
    }
    stage('results') {
        archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
    }
}
