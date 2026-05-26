FROM public.ecr.aws/docker/library/maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 mvn dependency:go-offline
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 mvn clean package

FROM eclipse-temurin:17-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring
WORKDIR /app
COPY --from=build --chmod=444 /app/target/*.jar app.jar
RUN mkdir -p /app/uploads && chown -R spring:spring /app/uploads
USER spring:spring
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]
