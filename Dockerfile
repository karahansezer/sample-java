# Use maven to build the application
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /app
COPY . /app
RUN mvn clean install

# Package the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.jar /app/my-app.jar
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]

FROM ubuntu
RUN apt -y update; apt-get -y install curl
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.6.2-amd64.deb
RUN dpkg -i filebeat-oss-7.6.2-amd64.deb
ADD filebeat.yml /etc/filebeat/filebeat.yml
