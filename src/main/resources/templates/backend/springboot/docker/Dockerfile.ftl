###########################
### STAGE 1: UNPACK JAR ###
###########################

# FROM
FROM openjdk:${ version.javaVersion }-jdk-alpine as UNPACK_JAR

# DEFINE VARIABLE
ARG JAR_FILE=target/${ info.artifactId }-1.0-SNAPSHOT.jar

# COPY JAR
COPY ${r"${JAR_FILE}"} app.jar

# EXTRACT FILES FROM FAT JAR
RUN jar -xf /app.jar

####################
### STAGE 2: RUN ###
####################

# FROM
FROM openjdk:${ version.javaVersion }-jdk-alpine

# SECURITY
# RUN addgroup -S spring && adduser -S spring -G spring
# USER spring:spring

# COPY FILES TO CREATE DOCKER LAYERS
COPY --from=UNPACK_JAR /BOOT-INF/lib /app/lib
COPY --from=UNPACK_JAR /META-INF /app/META-INF
COPY --from=UNPACK_JAR /BOOT-INF/classes /app

RUN apk add --no-cache bash

# RUN APP
EXPOSE 8080
ENTRYPOINT ["java", "-cp", "app:app/lib/*", "${ info.groupId }.MainApp"]
