FROM ballerina/ballerina:latest

COPY . /usr/src/GDKI_identity_service
WORKDIR /usr/src/GDKI_identity_service
USER root
RUN adduser -u 10001 -S appuser && chown -R 10001 /usr/src/GDKI_identity_service && \
    chmod -R 755 /usr/src/GDKI_identity_service
USER 10001
RUN bal persist generate
EXPOSE 8081
CMD ["bal", "run"]
