FROM maven:3-jdk-8

# create standard Vaadin stub project
RUN mkdir /webapp ; \
useradd --user-group --create-home vaadin ; \
chown vaadin:vaadin /webapp

USER vaadin
RUN cd /webapp ; \
mvn \
 --batch-mode archetype:generate \
 -DarchetypeGroupId=com.vaadin \
 -DarchetypeArtifactId=vaadin-archetype-application \
 -DarchetypeVersion=8.1.3 \
 -DgroupId=org.vaadin.vaadinfiddle \
 -DartifactId=fiddleapp \
 -Dversion=0.1

# compile the project
RUN cd /webapp/fiddleapp ; \
 mvn clean compile

# cache dependencies of jetty:run goal
RUN cd /webapp/fiddleapp ; \
 mvn jetty:start

# need to chage back to root user as the maven image runs some commands that expect rw permissions to /root/.m2/
USER root
