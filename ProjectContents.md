# Generated Kitura Server Project Contents

The `yo swiftserver` and `yo swiftserver:model` commands generate a number of assets as part of the Kitura project.

### Application Sources
This is the Kitura application code itself. The code is split into three areas:  
1. *Application* : This starts the Kitura server and adds general capabilities like configuration, monitoring, application health checking and hosting of the generated Swagger definition for the application.  
2. *Generated* : This contains the generated REST API routes (in `ServerMealResource.swift`) and model (in `ServerMeal.swift`), as well as the in-memory datastore that was selected (in `ServerMealMemoryAdapter.swift`)  
3. *FoodTrackerServer* : This is the launcher for the executable

```
// The application set up and addition of "utility" routes for monitoring, 
// health checks and hosting the swagger definition.
Sources/Application/Routes/SwaggerRoute.swift
Sources/Application/Application.swift

// 	The generated REST API and the generated ServerMeal model
Sources/Generated/CRUDResources.swift
Sources/Generated/ServerMealResource.swift
Sources/Generated/ServerMeal.swift

// The in-memory data store
Sources/Generated/AdapterFactory.swift
Sources/Generated/ServerMealAdaptor.swift
Sources/Generated/ServerMealMemorAdapter.swift

// Errors
Sources/Generated/AdapterError.swift		
Sources/Generated/ModelError.swift		

// The launcher for the executable
Sources/FoodTrackerServer/main.swift	
```

### Tests
A full set of tests are provided to validate the generated REST APIs. These can be executed through Xcode or by using `swift test` on the command line.

```
// Tests for the generated REST API routes
Tests/ApplicationTests/RouteTests.swift	
Tests/LinuxMain.swift		
```

### Swagger / OpenAPI specification
The Swagger (aka. OpenAPI specification) is provided via two means:  
1. *Hosted* : The swagger definition is hosted on /swagger/api. This is done so that it can be easily registered with API Gateways or used by client SDK generation tools  
2. *Visualized* : The swagger API is visualized on /explorer, which provides an easy interface to see the provided API and to do manual testing of the code.  

```
// The generated Swagger definition file itself
definitions/FoodTrackerServer.yaml
// A hosted web utility for visualizing the generated Swagger definition and and manually
// invoking the generated REST API
public/explorer/*						
```

### General Project Files
A number of general project files are also added, including an Xcode project, and Swift Package Manager config file and free to use license files.

```
// Local configuration file for the application
config.json
// Swift Package Manager configuration file
Package.swift	
// Xcode project
FoodTrackerServer.xcodeproj	
// Files not to add to any Git project
.gitignore							
// "Free to use" license and Apache 2.0 license for Swagger visualization utility
LICENSE
NOTICES.txt
```

### CocoaPod iOS SDK
A Swift iOS SDK is also added that provides the ability to make calls to the Kitura server using a `ServerMeal` class and a set of Swift functions:

```swift
ServerMealAPI.serverMealCreate(data: ServerMeal)
```

This removes the need to create your own URLSession calls that map to the REST API in Kitura, eg.  

```
// 	CocoaPod for install into your iOS application
FoodTrackerServer_iOS_SDK.zip	
```

### Server and Cloud Enablement
A number of files are added that provide configuration and enable for the applicaiton to be used in any of Docker, Kubernetes (via Helm) and Cloud Foundry.

```
// Configuration files for building "release" and "debug" Docker images
Dockerfile							
Dockerfile-tools						
.dockerignore	

// Configuration files to deploy the Docker image to a Kubernetes Cluster
chart/foodtrackerserver/templates/deployment.yaml
chart/foodtrackerserver/templates/service.yaml
chart/foodtrackerserver/Chart.yaml
chart/foodtrackerserver/values.yaml

// Configuration files to deploy to Cloud Foundry
manifest.yml							
.cfignore
```

### IBM Cloud Configuration Files
In addition to the Server and Cloud Enablement files which enables the application to be deployed to any cloud that implements those technologies, there are some additional files to work with some IBM Cloud provided utilities
1. *IBM Cloud DevOps* : This provides an integrated mechanism for building, testing and deploying your application to IBM Cloud by linking to your project in a Git repository.  
2. *IBM Developer Tools* : This provides tools for building and testing your application in a Docker image, and to deploy your application to IBM Cloud.

```
// Configuration files for using the Bluemix CI/CD pipelines
.bluemix/*
// Configuration file for IBM Developer Tools (IDT) command line.
cli-config.yml
// Provides a button for "Deploy to Bluemix". Must be used from GitHub.
README.md							