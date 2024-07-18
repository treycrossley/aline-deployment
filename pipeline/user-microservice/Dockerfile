FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the application JAR file
COPY user-microservice/target/user-microservice-0.1.0.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8070

# Run the application
CMD ["java", "-jar", "user-microservice-0.1.0.jar"]
