FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the application JAR file
COPY underwriter-microservice/target/underwriter-microservice-0.1.0.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8071

# Run the application
CMD ["java", "-jar", "underwriter-microservice-0.1.0.jar"]