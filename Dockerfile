FROM ballerina/ballerina:latest

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# Create a new user
RUN useradd -ms /bin/bash 10001

# Set permissions for the myapp folder
RUN mkdir /usr/src/myapp && chown -R 10001:10001 /usr/src/myapp

# Switch to the new user
USER 10001

RUN ls
RUN bal persist generate


WORKDIR /usr/src/myapp/generated
RUN ls

EXPOSE 8081
CMD ["bal", "run"]
