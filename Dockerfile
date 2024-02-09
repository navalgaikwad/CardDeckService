# Run the jar file
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/card-deck-service-0.0.1-SNAPSHOT.jar"]

#
# Build stage
#
FROM maven:3.8.2-amazoncorretto:17 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#
FROM amazoncorretto:17
COPY --from=build /target/card-deck-service-0.0.1-SNAPSHOT.jar demo.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]