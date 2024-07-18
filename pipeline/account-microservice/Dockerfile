FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the application JAR file
COPY account-microservice/target/account-microservice-0.1.0.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8072

# Run the application
CMD ["java", "-jar", "account-microservice-0.1.0.jar"]