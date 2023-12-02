FROM ballerina/ballerina:latest

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN addgroup -g 1001 -S appuser && adduser -u 1001 -S appuser -G appuser
RUN chown -R appuser:appuser /usr/src/myapp
USER appuser
RUN ls
RUN bal persist generate
WORKDIR /usr/src/myapp/generated
EXPOSE 8081
CMD ["bal", "run"]
