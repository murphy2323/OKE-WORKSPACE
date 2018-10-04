FROM openjdk:8
ADD ./distribution/target/appassembler/ /usr/src/target/
WORKDIR /usr/src/target
EXPOSE 8080
CMD ./bin/Main
