pipeline {
  agent {label 'docker-adas-android'}
    stages {
	stage('Import Base Docker Image') {
            steps {
                sh '''#!/bin/bash -xe
                   if test ! -z "$(docker images -q python:3.6)"; then
                      echo "Docker Image Already Exist!!!"
                   else
                      pv -f /media/common/DOCKER_IMAGES/Basic/python-3.6.tar | docker load
                      docker tag 749d36d00e00 python:3.6
                      echo "DONE!!!"
                   fi
		            ''' 
            }
        }
        stage('Build yi/adas-build:android Docker Image') {
            steps {
	        sh '''
		   docker build --no-cache -f Dockerfile.Python3.6-Build -t yi/adas:python3.6-build .
		   docker build --no-cache -f Dockerfile.Python3.6-Build-Android -t yi/adas-build:android-tensorflow .
		   '''
            }
        }
	    stage('Test yi/adas-build:android Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		   echo 'Hello, Android-Build!!'
		   image_id="$(docker images -q yi/adas-build:android-tensorflow)"
		      if [[ "$(docker images -q yi/adas-build:android-tensorflow 2> /dev/null)" == "$image_id" ]]; then
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
		docker save yi/adas-build:android-tensorflow | pv -f | cat > $WORKSPACE/yi-adas-build-android-tensorflow.tar
				  
	        echo 'Remove Original Docker Images' 
		CURRENT_ID=$(docker images | grep -E '^yi/adas-build.*android-tensorflow' | awk -e '{print $3}')
		docker rmi -f $CURRENT_ID
		docker rmi -f yi/adas:python3.6-build
		docker rmi -f python:3.6
				 
		echo 'Loading Docker Image'
		pv -f $WORKSPACE/yi-adas-build-android-tensorflow.tar | docker load
		docker tag $CURRENT_ID yi/adas-build:android-tensorlow
				  
	        echo 'Removing temp archive.'  
		rm $WORKSPACE/yi-adas-build-android-tensorflow.tar
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
