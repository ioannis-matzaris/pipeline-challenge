# Pipeline Challenge

A simple Java application that prints **"Hello World"** to the console every 2 seconds. Built using **Gradle** and requires **Java 25** or higher.  

The application is deployed on a Kubernetes cluster using **Argo CD** and **Argo CD Image Updater**, which automatically detects new container images and updates the deployment according to the `application.yaml` manifest.

The repository also includes a **CI/CD pipeline** implemented with GitHub Actions.

The pipeline automatically runs tests, builds the Java application, creates a Docker image, pushes it to GitHub Container Registry (GHCR) and triggers Argo CD to deploy the latest version, achieving full Continuous Deployment.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Build & Run](#build--run)
  - [Using Gradle Wrapper](#using-gradle-wrapper)
  - [Build JAR and Run](#build-jar-and-run)
  - [Build and Run with Docker](#build-and-run-with-docker)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Sample Output](#sample-output)
- [Pipeline](#pipeline)
- [Continuous Deployment Requirements](#continuous-deployment-requirements)
- [License](#license)

---

## Prerequisites

Before running the project, make sure you have:

- **Java 25 or higher**  
  Check with:

  ```bash
  java -version
  ```

- **Gradle** (optional if using the Gradle Wrapper)  
  Check with:

  ```bash
  gradle -v
  ```

> ⚡ macOS/linux users can use the Gradle Wrapper included in the project (`./gradlew`) so a global Gradle installation is **not required**.

---

## Build & Run

### Using Gradle Wrapper (Recommended)

From the project root:

```bash
# Compile and run the application
./gradlew :app:run
```

This will start the application and print:

```text
Hello World
Hello World
Hello World
...
```

Press `Ctrl+C` to stop.

---

### Build JAR and Run

1. Build the project:

```bash
./gradlew :app:build
```

2. Run the executable JAR:

```bash
java -jar app/build/libs/app.jar
```

---

### Build and Run with Docker

You can also build and run the application using Docker.

#### Build Docker Image

From the project root:

docker build -t pipeline-challenge:latest .

#### Run Docker Container
docker run pipeline-challenge

This will start the application inside a container and print:

Hello World
Hello World
Hello World
...

Press Ctrl+C to stop the container.
--- 

## Project Structure

```
pipeline-challenge/
 ├── app/
 │   ├── src/test/java/org/...
 │   └── build.gradle.kts
 ├── gradle/
 ├── gradlew
 ├── gradlew.bat
 └── settings.gradle.kts
```

---

## Testing

The project uses **JUnit 4** (default generated).  

Run tests using:

```bash
./gradlew :app:test
```

---

## Sample Output

```
$ ./gradlew :app:run
> Task :app:run
Hello World
Hello World
Hello World
Hello World
...
```

Press `Ctrl+C` to stop the application.

---

---

## Pipeline

For an overview of the high-level CI/CD architecture, see the detailed documentation in [PIPELINE.md](docs/PIPELINE.md).

---

## Continuous Deployment Requirements
For the full list of prerequisites to enable Continuous Deployment, see [CONTINUOUS_DEPLOYMENT_REQUIREMENTS.md](docs/CONTINUOUS_DEPLOYMENT_REQUIREMENTS.md).

---

## License

This project is open source and free to use.
