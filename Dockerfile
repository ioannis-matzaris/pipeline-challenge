ARG BUILD_IMAGE=gradle:9.2.1-jdk25-alpine
ARG RUNTIME_IMAGE=gcr.io/distroless/java25

# Stage 1: Build the JAR with Gradle
FROM ${BUILD_IMAGE} AS build

WORKDIR /app

# Copy Gradle wrapper and configs for caching
COPY gradlew settings.gradle.kts gradle.properties ./
COPY gradle/ gradle/
COPY app/build.gradle.kts app/

# Pre-download dependencies for caching
RUN ./gradlew build -x test --no-daemon

# Copy source code
COPY app/src/ app/src/

# Build the app
RUN ./gradlew :app:build --no-daemon

# Stage 2: Run the application with Distroless
FROM ${RUNTIME_IMAGE}

WORKDIR /app

# Copy the built JAR
COPY --from=build /app/app/build/libs/app.jar ./app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]