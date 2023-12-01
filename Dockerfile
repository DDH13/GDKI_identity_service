FROM ballerina/ballerina:latest

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

RUN bal persist generate
CMD ["bal", "run"]

USER 10001
