FROM java:8
WORKDIR /
ADD work/payment-hub-1.0.0-SNAPSHOT.jar payment-hub-1.0.0-SNAPSHOT.jar
ADD work/application.yml application.yml
ADD work/jssecacerts /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security

EXPOSE 80 48888 48889 58080 58180 58181
CMD ["java", "-jar", "payment-hub-1.0.0-SNAPSHOT.jar"]

