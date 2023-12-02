FROM ballerina/ballerina:latest

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN adduser -u 10001 -S appuser && chown -R 10001 /usr/src/myapp
USER 10001
RUN ls
RUN bal persist generate
WORKDIR /usr/src/myapp/generated
EXPOSE 8081
CMD ["bal", "run"]
