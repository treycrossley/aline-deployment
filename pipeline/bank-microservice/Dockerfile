FROM openjdk:11-jre-slim

WORKDIR /app


# Copy the application JAR file
COPY bank-microservice/target/bank-microservice-0.1.0.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8083

# Run the application
CMD ["java", "-jar", "bank-microservice-0.1.0.jar"]