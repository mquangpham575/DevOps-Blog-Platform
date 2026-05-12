FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY ci-artifacts/*.jar app.jar
EXPOSE 8087
ENTRYPOINT ["java", "-jar", "app.jar"]
