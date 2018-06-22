#Last version with multi stage for kubernetes demo
FROM cpruvost/minimal-jdk8 as build

#Install Maven
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

# Create app directory; same as Wercker default
RUN mkdir -p /pipeline/source
WORKDIR /pipeline/source

# Bundle app source
COPY . /pipeline/source/
RUN mvn clean package

#Only last image will stay
FROM cpruvost/minimal-java8

# Create app directory; same as Wercker default
RUN mkdir -p /pipeline/source
WORKDIR /pipeline/source

COPY --from=build /pipeline/source/target/rest-example-0.2.0.jar /pipeline/source/rest-example-0.2.0.jar
CMD java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -jar /pipeline/source/rest-example-0.2.0.jar

EXPOSE 8090

