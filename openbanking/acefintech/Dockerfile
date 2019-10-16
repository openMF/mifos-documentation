FROM openjdk:11
WORKDIR /
RUN mkdir config
ADD target/backend-0.0.1-SNAPSHOT.jar backend-0.0.1-SNAPSHOT.jar
ADD config/application.properties config/application.properties

EXPOSE 8080 
CMD ["java", "-jar", "backend-0.0.1-SNAPSHOT.jar", "--spring.config.location=file:./config/"]
