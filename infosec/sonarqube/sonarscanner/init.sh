#!/usr/bin/env bash

while ! nc -z sonarqube 9000;
        do
          echo 'Waiting for sonarqube server ...';
          sleep 2;
done;
echo "-------- Sleeping 60 seconds ------------";
sleep 60;
echo "-------- Scanning project for code smells and infosec issue ------------";
sonar-scanner -Dsonar.projectBaseDir=/usr/src