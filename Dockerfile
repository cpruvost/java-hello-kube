#Old Docker File to build a minimal java 8 image
#FROM alpine:3.6
#RUN apk --update add openjdk8-jre
#CMD ["/usr/bin/java", "-version"]

#New docker File to build my microservice container
FROM cpruvost/minimal-java8
VOLUME /tmp
RUN mkdir -p /home/myapp
WORKDIR /home/myapp
COPY ./target/rest-example-0.2.0.jar /home/myapp
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/home/myapp/rest-example-0.2.0.jar"]
EXPOSE 8090
