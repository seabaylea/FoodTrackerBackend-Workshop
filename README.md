# Building a Swift Backend for FoodTracker

This tutorial teaches how to create a Server-Side Swift backend for the [FoodTracker iOS app tutorial](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/) from Apple.

For more information about Swift@IBM, visit https://developer.ibm.com/swift/

### Pre-Requisites:
**Install the Swift Server Generator:**  
1. Ensure that you have Node.js 8.0 installed:  
`node —v` 
2. If Node.js isn’t installed, you can download and install it:  
https://nodejs.org/download/release/v8.0.0/node-v8.0.0.pkg 
3. Install Yeoman:  
`npm install -g yo` 
4. Install Swift Server Generator:  
`npm install -g generator-swiftserver`

**Ensure you have CocoaPods installed**  
1. Install CocoaPods:
`sudo gem install cocoapods`


**Clone this project:**  
1. Clone this project from GitHub to your machine (don't use the Download ZIP option):  
```
cd ~
git clone http://github.com/seabaylea/FoodTrackerBackend-Workshop
cd ~/FoodTrackerBackend-Workshop
```

## Getting Started
**1. Run the Food Tracker App:**  
1. Change into the iOS app directory:  
```
cd ~/FoodTrackerBackend-Workshop/iOS/FoodTracker
```
2. Open the Xcode Project 
`open FoodTracker.xcodeproj`
3. Run the project to ensure that its working
    1. Hit the build and run button
    2. Add a meal in the Simulator
    3. Check that you receive a “Meals successfully saved.” message in the console

**2. Create and run a Kitura Server to Persist data from FoodTracker**
1. Create a directory for the server project
```
mkdir ~/FoodTrackerBackend-Workshop/Server
cd ~/FoodTrackerBackend-Workshop/Server
```
2. Run Swift Server Generator:
```
yo swiftserver
What's the name of your application? > FoodTrackerServer
Enter the name of the directory to contain the project: FoodTrackerServer
```
Select a type of project. `Scaffold a starter` allows you to create a Basic, Web or Backend for Frontend project (including creating REST APIs) whereas `Generate a CRUD application` (Create, Read, Update, Delete) is designed to do data persistence. Select a CRUD application.
```
Select type of project: 
  Scaffold a starter 
❯ Generate a CRUD application
Select capabilities: (Press <space> to select, <a> to toggle all, <i> to inverse selection)
❯◉ Embedded metrics dashboard
 ◉ Docker files
 ◉ Bluemix cloud deployment
```
Select whether you want to access other services using a Swift server SDK that's automatically generated from a Swagger definition for that service.
```
Service prompts
? Would you like to generate a Swift server SDK from a Swagger file? (y/N) N
```
Select a datastore. For a production server you would want to persist data to a database, but for this workshop we'll use an in-memory datastore for ease of setup:  
```
Select data store: 
❯ Memory (for development purposes) 
  Cloudant / CouchDB
Generate boilerplate for Bluemix services: 
❯◉ Auto-scaling
```
The Swift Server generator will now create and build an empty Kitura application for you with the characteristics you selected. As you are building a CRUD application, you now need to add a data model that it provides Create Read Update and Delete operations for.

3. Add a data model to persist to the datastore
```
cd ~/FoodTrackerBackend-Workshop/Server/FoodTrackerServer
yo swiftserver:model
Enter the model name: ServerMeal
? Custom plural form (used to build REST URL): ServerMeals
Let's add some ServerMeal properties now.

Enter an empty property name when done.
? Enter the property name: name
? Property type: (Use arrow keys)
❯ string 
  number 
  boolean 
  object 
  array
? Required? (y/N) y
? Default? (y/N) n
? Enter the property name: photo
? Property type: (Use arrow keys)
❯ string 
  number 
  boolean 
  object 
  array 
? Required? (y/N) y
? Default? (y/N) n
? Enter the property name: rating
? Property type: 
  string 
❯ number 
  boolean 
  object 
  array
? Required? (y/N) y
? Default? (y/N) n
? Enter the property name:
```
When you get to the final `Enter the property name:`, just tap Enter and your new model will be generated.

This has created a full Kitura Server project that provides CRUD operations for the `ServerMeal` object. Additionally an iOS SDK called `FoodTrackerServer_iOS_SDK.zip` has automatically been created in the root directly of the project in order to make it easy to connect to the server from your application.

4. Open and run the server project in Xcode
    1. Open the project in Xcode:
`open FoodTrackerServer.xcodeproj`
    2. Edit the scheme and select a Run Executable of “FoodTrackerServer”
    3. Make sure you are running a Swift 3.1 Toolchain in `Xcode > Toolchains`
    3. Run the project, then "Allow incoming network connections" if you are prompted.

5. Check the FoodTrackerServer URLs are running:
    * Kitura Homepage: http://localhost:8080
    * Kitura Monitoring: http://localhost:8080/swiftmetrics-dash/
    * Kitura REST API: http://localhost:8080/explorer/

6. Test the REST API is running correctly
    1. From the Kitura REST API explorer select “GET /ServerMeals”
    2. Press the “Try it out!” button
    3. Check for an empty response body (“[]”) and a Response Code of 200. This tests that no meals have been saved to the server yet.

**Install the iOS SDK into the FoodTracker iOS application:**  
In order for the FoodTracker iOS application to save the meal data to the server, calls to the server's REST APIs need to be made. This could be done using `URLSession`, but in order to make it easier to create the correct data objects and API calls, the generated iOS SDK provides ServerMeal and ServerMealAPI classes. 
1. Unzip the `FoodTrackerServer_iOS_SDK.zip` file:
```
cd ~/FoodTrackerBackend-Workshop
unzip ~/FoodTrackerBackend-Workshop/Server/FoodTrackerServer/FoodTrackerServer_iOS_SDK.zip
```
2. Create a Podfile in the FoodTracker iOS application directory:
```
cd ~/FoodTrackerBackend-Workshop/iOS/FoodTracker/
pod init
```
3. Edit the Podfile to use install the FoodTrackerServer SDK:
```
open Podfile
```
Under the "# Pods for FoodTracker" line add:
```
  # Pods for FoodTracker
  pod 'FoodTrackerServer_iOS_SDK', :path => ‘~/FoodTrackerBackend-Workshop/FoodTrackerServer_iOS_SDK’
  ```
4. Install the iOS SDK:
 ```
 pod install
 ```

**Update FoodTracker to call the FoodTrackerServer:**  
As the iOS SDK is installed as a Pod, the FoodTracker application now needs to be updated to call the provided APIs. The FoodTracker application provided already includes that code. As a result, you only need to uncomment the code that invokes those APIs:

1. If the FoodTracker iOS application is open in Xcode, close it.
2. Open the FoodTracker applications Workspace (not project!):
```
cd ~/FoodTrackerBackend-Workshop/iOS/FoodTracker/
open FoodTracker.xcworkspace
```
3. Edit the `FoodTracker > MealTableViewController.swift` file:
    1. Uncomment the import of `import FoodTrackerServer_iOS_SDK`
    ```swift
    import FoodTrackerServer_iOS_SDK
    ```
    2. Uncomment the following at the start of the saveMeals() function:
    ```swift
            for meal in meals {
                  saveToServer(meal: meal)
              }
    ```
    3. Uncomment the following `saveToServer(meal:)` function towards the end of the file:
    ```swift
    private func saveToServer(meal: Meal) {
        ServerMealAPI.serverMealCreate(data: meal.asServerMeal()) { (returnedData, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if let result = returnedData {
                print(result)
            }
            if let status = response?.statusCode {
                print("ServerMealAPI.serverMealCreate() finished with status code: \(status)")
            }
        }
    }
    ```
    4. Uncomment the following `asServerMeal()` extension to `Meal` at the end of the file:
    ```swift
    extension Meal {
        func asServerMeal() -> ServerMeal {
            let serverMeal = ServerMeal()
            serverMeal.name = self.name
            serverMeal.photo = UIImageJPEGRepresentation(self.photo!, 0)?.base64EncodedString()
            serverMeal.rating = Double(self.rating)
            return serverMeal
        }
    }
    ```
4. Edit the `Pods > Development Pods > FoodTrackerServer_iOS_SDK > Resources > FoodTrackerServer_iOS_SDK.plist` file to set the hostname and port for the FoodTrackerBackend server (in this case adding a port number of `8080`):
```
FoodTrackerServer_iOS_SDKHost = http://localhost:8080/api
```
5. Update the FoodTracker applications `FoodTracker > Info.plist` file to allow loads from a server:
**note** this step has been done already:
```
    <key>NSAppTransportSecurity</key>
	<dict>
	    <key>NSAllowsArbitraryLoads</key>
        	<true/>
	</dict>
```

**Run the FoodTracker app with storage to the Kitura server**
1. Make sure the Kitura server is still running and you have the Kitura monitoring dashboard open in your browser (http://localhost:8080/swiftmetrics-dash)
2. Build and run the FoodTracker app in the iOS simulator and add or remove a Meal entry
3. View the monitoring panel to see the responsiveness of the API call
4. Check the data has been persisted by the Kitura server
    1. Go the to REST API explorer:    http://localhost:8080/explorer/
    2. From the Kitura REST API explorer select “GET /ServerMeals”
    3. Press the “Try it out!” button
    4. Check for a response body that contains data and a Response Code of 200
    
Congratulations, you have successfully persisted data from an iOS app to a serverside Swift backend!

**Add a Web Application to the Kitura server (bonus content, if you have time)**
1. Update the Kitura server application to save the received images to the local file system:
    1. Open the `Sources/Generated/ServerMealResource.swift` source file that contains the REST API routes
    2. Import Foundation:
    `import Foundation`
    3. Update the `handleCreate()` function to add the following after the `let model = try ServerMeal(json: json)` statement to save the images:
    **note:** `<USER_NAME>` should be substituted with your user name
      ```swift
            let photoData = Data(base64Encoded: model.photo)
            let fileManager = FileManager.default
            let publicDirectory = "/Users/<USER_NAME>/FoodTrackerBackend-Workshop/Server/FoodTrackerServer/public/"
            fileManager.createFile(atPath: publicDirectory + model.name + ".jpg", contents: photoData)
      ```
    4. Create a `~/FoodTrackerBackend-Workshop/Server/FoodTrackerServer/public/jpeg.html` file containing just: 
    `<img src="Caprese Salad.jpg">`
    5. Re-build and run the server

   
**Rerun the FoodTracker iOS App and view the Web App** 
1. Run the iOS app in XCode and add or remove a Meal entry
2. Visit the web application at to see the saved image:
`http://localhost:8080/jpeg.html`
