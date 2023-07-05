# Use maven to build the application
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /app
COPY . /app
RUN mkdir -p /app/logs && touch /app/logs/app.log && chown -R user:user /app/logs
RUN mvn clean install

# Package the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.jar /app/my-app.jar
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]

