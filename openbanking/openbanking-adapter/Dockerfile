FROM java:8
WORKDIR /
ADD work/openbanking-adapter-1.0.0-SNAPSHOT.jar openbanking-adapter-1.0.0-SNAPSHOT.jar
ADD work/application.yml application.yml

EXPOSE 80 62020 62021
CMD ["java", "-jar", "openbanking-adapter-1.0.0-SNAPSHOT.jar"]

