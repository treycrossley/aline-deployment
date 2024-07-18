FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the application JAR file
COPY target/aline-gateway-0.0.1-SNAPSHOT.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "aline-gateway-0.0.1-SNAPSHOT.jar"]