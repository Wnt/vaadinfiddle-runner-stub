FROM maven:3-jdk-8

# need to use "--settings /usr/share/maven/ref/settings-docker.xml" in all mvn commands to persist cached artifacts

# create standard Vaadin stub project
RUN mkdir /webapp
RUN cd /webapp ; \
mvn --settings /usr/share/maven/ref/settings-docker.xml \
 --batch-mode archetype:generate \
 -DarchetypeGroupId=com.vaadin \
 -DarchetypeArtifactId=vaadin-archetype-application \
 -DarchetypeRepository=https://maven.vaadin.com/vaadin-prereleases \
 -DarchetypeVersion=8.0.0.beta1 \
 -DgroupId=org.vaadin.vaadinfiddle \
 -DartifactId=fiddleapp \
 -Dversion=0.1

# compile the project 
RUN cd /webapp/fiddleapp ; \
 mvn --settings /usr/share/maven/ref/settings-docker.xml compile

# cache dependencies of jetty:run goal
RUN cd /webapp/fiddleapp ; \
 mvn --settings /usr/share/maven/ref/settings-docker.xml jetty:start

RUN echo foo > /bar
#CMD cd /webapp/fiddleapp && mvn --settings /usr/share/maven/ref/settings-docker.xml jetty:run
