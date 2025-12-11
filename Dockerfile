ARG BUILD_IMAGE=gradle:9.2.1-jdk25-alpine
ARG RUNTIME_IMAGE=gcr.io/distroless/java25

FROM ${BUILD_IMAGE} AS build
WORKDIR /app

COPY gradlew settings.gradle.kts gradle.properties ./
COPY gradle/ gradle/
COPY app/build.gradle.kts app/

RUN ./gradlew build -x test --no-daemon

COPY app/src/ app/src/

RUN ./gradlew :app:build --no-daemon

FROM ${RUNTIME_IMAGE}

WORKDIR /app

COPY --from=build /app/app/build/libs/app.jar ./app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]