## TO build container image
docker build -t thoughtlane/jdk-12.0.1_12 .
docker push thoughtlane/jdk-12.0.1_12


docker volume rm maven-local-cache
docker volume rm gradle-cache



## Below command creates cache if doesn't exist( Not useful for parallel execution) 
docker volume ls | grep -q "gradle-cache" && docker volume create --name gradle-cache

# Create Maven Local volume
docker volume ls | grep -q "maven-local-cache" && docker volume create --name maven-local-cache

docker volume create --opt type=none --opt o=bind --opt device=/host-path  myvolume

## TO build any project. Run this command in place of default gradle command
docker run --rm -u gradle -v maven-local-cache:/home/gradle/.m2/ -v gradle-cache:/home/gradle/.gradle -v "$PWD":/home/gradle/project -w /home/gradle/project us.gcr.io/dev-answers7/jdk-12.0.1_12:1.0 gradle clean build -x test
