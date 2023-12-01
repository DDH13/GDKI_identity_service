FROM ballerina/ballerina:latest
RUN groupadd -r dineth && useradd -r -g dineth dineth

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

RUN bal persist generate
CMD ["bal", "run"]

RUN chown -R dineth:dineth /myapp
USER dineth
