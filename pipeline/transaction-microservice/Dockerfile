FROM openjdk:11-jre-slim

WORKDIR /app


# Copy the application JAR file
COPY transaction-microservice/target/transaction-microservice-0.1.0.jar /app/

# Expose the port specified in the application.yml file
EXPOSE 8073

# Run the application
CMD ["java", "-jar", "transaction-microservice-0.1.0.jar"]