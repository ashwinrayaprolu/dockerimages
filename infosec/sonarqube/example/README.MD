## Flaskr an example application written in Python/Flask


Original source code from https://github.com/pallets/flask/tree/master/examples/tutorial

## Docker instructions

To create a docker image execute: 

`docker build . -t flaskr`

To run the docker image execute:

`docker run -p 5000:5000 flaskr` and visit with your browser http://localhost:5000

To run unit tests inside the container execute:

`docker run -it flaskr /bin/sh`

and then in the new command promt run

`pip install pytest && pytest`

## To use this project in Sonarqube

(cd example/ && docker build . -t flaskr )
(cd example/ && docker run -v $(pwd)/target/:/mnt/app/ --rm  flaskr ls -la )

(cd example && docker build -f pytest/Dockerfile . -t pytest_container )
(cd example && docker run -v $(pwd)/target/:/mnt/app/ --rm pytest_container cp coverage.xml /mnt/app/ )

 pytest -o junit_family=xunit1 --junitxml=tests/nosetests.xml
