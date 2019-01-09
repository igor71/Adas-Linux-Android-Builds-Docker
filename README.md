# Adas-Linux-Android-Builds-Docker
Create Build Environment For Linux &amp; Android Inside Docker Container

### Creating ADAS Android & Linux Build Docker Images Manually
```
git clone --branch=master --depth=1 github.com/igor71/Adas-Linux-Android-Builds-Docker/

cd Adas-Linux-Android-Builds-Docker

docker build -f Dockerfile.ADAS-Linux-PY2.7 -t yi/adas-build:0.0 . >> Python 2.7 >> Linux Build (Deprecated)

docker build -f Dockerfile.ADAS-Linux-PY3.6 -t yi/adas-build:0.0 . >> Python 3.6 >> Linux Build

docker build -f Dockerfile.ADAS-Android-PY3.6 -t yi/adas-build:0.0 . >> Android Build
```
Continue with relevant Manual Steps For Docker-Build... file for rest configuration changes.
