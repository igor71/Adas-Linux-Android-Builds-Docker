# Adas-Linux-Android-Builds-Docker
Jenkins Job >> Create Build Environment For Linux &amp; Android Inside Docker Container

### Creating ADAS Android Build Docker Image Manually
```
git clone --branch=android --depth=1 github.com/igor71/Adas-Linux-Android-Builds-Docker/

cd Adas-Linux-Android-Builds-Docker

docker build -f Dockerfile.Python3.6-Build-Linux -t yi/adas-build:linux .

docker build -f Dockerfile.Python3.6-Build-Linux -t yi/adas-build:linux .  >> Android Build
```
Continue with Auto Steps For Docker-Build... file for test build.
