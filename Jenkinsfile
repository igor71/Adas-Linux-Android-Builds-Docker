pipeline {
  agent {label 'docker-adas-linux'}
    stages {
	stage('Import Base Docker Image') {
            steps {
                sh '''#!/bin/bash -xe
                   if test ! -z "$(docker images -q ubuntu:16.04)"; then
                      echo "Docker Image Already Exist!!!"
                   else
                      pv -f /media/common/DOCKER_IMAGES/Basic/ubuntu-16.04.tar | docker load
                      docker tag b9e15a5d1e1a ubuntu:16.04
                      echo "DONE!!!"
                   fi
		            ''' 
            }
        }
        stage('Build yi/adas-build:linux Docker Image') {
            steps {
	        sh 'docker build --no-cache -f Dockerfile.Python3.6-Build-Linux -t yi/adas-build:linux .'  
            }
        }
	    stage('Test yi/adas-build:linux Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		   echo 'Hello, Linux-Build!!'
		   image_id="$(docker images -q yi/adas-build:linux)
		      if [[ "$(docker images -q yi/adas-build:linux 2> /dev/null)" == "$image_id" ]]; then
		         docker inspect --format='{{range $p, $conf := .RootFS.Layers}} {{$p}} {{end}}' $image_id
                      else
		         echo "It appears that current docker image corrapted!!!"
                      exit 1
                      fi 
                   ''' 
            }
        }
        stage('Save & Load Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		echo 'Saving Docker image into tar archive'
		docker save yi/adas-build:linux | pv -f | cat > $WORKSPACE/yi-adas-build-linux.tar
				  
	        echo 'Remove Original Docker Image' 
		CURRENT_ID=$(docker images | grep -E '^yi/adas-build.*linux' | awk -e '{print $3}')
		docker rmi -f $CURRENT_ID
				 
		echo 'Loading Docker Image'
		pv -f $WORKSPACE/yi-adas-build-linux.tar | docker load
		docker tag $CURRENT_ID yi/adas-build:linux
				  
	        echo 'Removing temp archive.'  
		rm $WORKSPACE/yi-adas-build-linux.tar
                   ''' 
		    }
		}
 }
	post {
            always {
               script {
                  if (currentBuild.result == null) {
                     currentBuild.result = 'SUCCESS' 
                  }
               }
               step([$class: 'Mailer',
                     notifyEveryUnstableBuild: true,
                     recipients: "igor.rabkin@xiaoyi.com",
                     sendToIndividuals: true])
            }
         } 
}
