
# Stage 1: Build the Maven application
FROM maven:3.9-eclipse-temurin-11 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run the application using Tomcat
FROM tomcat:10.1.61-jdk11-temurin

# Copy the generated WAR into Tomcat
COPY --from=build /app/target/Pathway-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Render uses the PORT environment variable
EXPOSE 10000

# Configure Tomcat to use Render's port
CMD sed -i "s/port=\"8080\"/port=\"${PORT:-10000}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run
