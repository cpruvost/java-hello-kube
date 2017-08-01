FROM cpruvost/myjava8

# Create app directory; same as Wercker default
RUN mkdir -p /pipeline/source
WORKDIR /pipeline/source

# Bundle app source
COPY . /pipeline/source/
RUN mvn install

EXPOSE 8090
ENTRYPOINT exec java -jar ./target/demo-0.0.1-SNAPSHOT.jar
