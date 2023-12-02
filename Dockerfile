FROM ballerina/ballerina:latest

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

RUN ls
RUN bal persist generate
USER 10016
EXPOSE 8081
CMD ["bal", "run"]
