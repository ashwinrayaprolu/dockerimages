## TO build container image
docker build -t thoughtlane/jdk-12.0.1_12 .
docker image tag 247ai-answers/jdk-12.0.1_12 us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0
docker push us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0

docker pull nexus.cicd.sv2.247-inc.net:5000/answers/jdk-12.0.1_12:1.0
docker image tag nexus.cicd.sv2.247-inc.net:5000/answers/jdk-12.0.1_12:1.0 247ai-answers/jdk-12.0.1_12



docker volume rm maven-local-cache
docker volume rm gradle-cache

## Pull Docker Image from repository (One time task)
docker pull  us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0

## Below command creates cache if doesn't exist( Not useful for parallel execution) 
docker volume ls | grep -q "gradle-cache" && docker volume create --name gradle-cache

docker volume create --opt type=none --opt o=bind --opt device=/host-path  myvolume

docker volume create --opt type=none --opt o=bind --opt device="/Users/ashwin.rayaprolu/Development/A7A-Demo/ir-infra/DockerContents/answers/vol/a7gcpdev" answers-mnt

# Create Maven Local volume
docker volume ls | grep -q "maven-local-cache" && docker volume create --name maven-local-cache



## TO build any project. Run this command in place of default gradle command
docker run --rm -u gradle -v maven-local-cache:/home/gradle/.m2/ -v gradle-cache:/home/gradle/.gradle -v "$PWD":/home/gradle/project -w /home/gradle/project us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0 gradle clean build -x test



docker run --rm -u gradle -v maven-local-cache:/home/gradle/.m2/ -v gradle-cache:/home/gradle/.gradle -v "$PWD":/home/gradle/project -w /home/gradle/project us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0 ls -la /home/gradle/.m2/repository/com/tfs/answers/