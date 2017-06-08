## Building a Swift Backend for FoodTracker

### Pre-Requisites:
**Install the Swift Server Generator:**  
1. Ensure that you have Node.js installed:  
`node —version` 
2. If Node.js isn’t installed, you can install it:  
`brew install node` 
3. Install Yeoman:  
`npm install -g yo` 
4. Install Swift Server Generator:  
`npm install -g generator-swiftserver`

**Clone this project:**  
1. Clone this project from GitHub to your machine:  
```
cd ~
git clone http://github.com/seabaylea/FoodTrackerBackend-Workshop
cd ~/FoodTrackerBackend-Workshop
```

## Getting Started
**1. Run the Food Tracker App:**  
1. Unzip the FoodTracker App (09_PersistData.zip) into a suitable directory:  
```
cd ~/FoodTrackerBackend-Workshop/iOS/
```
2. Open the Xcode Workspace  
`open FoodTracker.xcworkspace`
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
Select a type of project. Starter allows you to create general Basic, Web or Backend for Frontend project, including creating REST APIs, whereas a Create Read Update Delete (CRUD) project if designed to do data persistence. Select a CRUD application.
```
Select type of project: 
  Scaffold a starter 
❯ Generate a CRUD application
Select capabilities: (Press <space> to select, <a> to toggle all, <i> to inverse selection)
❯◉ Embedded metrics dashboard
 ◉ Docker files
 ◉ Bluemix cloud deployment
```
Select a datastore. For a production server you would want to persist data to a database, but for this workshop we'll use an in-memory datastore for ease of setup:  
```
Select data store: 
❯ Memory (for development purposes) 
  Cloudant / CouchDB
Generate boilerplate for Bluemix services: 
❯◉ Auto-scaling
```
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
4. Open and run the server project in Xcode
    1. Open the project in Xcode:
`open FoodTrackerServer.xcodeproj`
    2. Edit the scheme and select a Run Executable of “FoodTrackerServer”
    3. Run the project

5. Check the FoodTrackerServer URLs are running:
    * Kitura Homepage: http://localhost:8080
    * Kitura Monitoring: http://localhost:8080/swiftmetrics-dash/
    * Kitura REST API: http://localhost:8080/explorer/

6. Test the REST API is running correctly
    1. From the Kitura REST API explorer select “GET /ServerMeals”
    2. Press the “Try it out!” button
    3. Check for an empty response body (“[]”) and a Response Code of 200


**Update FoodTracker to call the FoodTrackerServer:**  
In order for FoodTracker iOS application to save the Meal data to the server, calls to the server's REST APIs need to be made. This could be done via calls to URLSession, but in order to make it easier to create the correct data objects and API calls, ServerMeal and ServerMealAPI classes are provided. These are generated using the IBM Cloud SDK Generator but have already been embedded into the FoodTracker iOS application for this workshop.  

As a result you only need to uncomment the code that invokes those APIs:

1. Open the FoodTracker app project:
```
cd ~/FoodTrackerBackend-Workshop/iOS/FoodTracker/
open FoodTracker.xcworkspace
```
2. Edit MealTableViewController.swift
    1. Uncomment the following at the start of the sameMeals() function:
```
            for meal in meals {
                  saveToServer(meal: meal)
              }
```


**Run the FoodTracker app with storage to the Kitura server**
1. Make sure the Kitura server is running
Either by running  
`~/FoodTrackerBackend-Workshop/Server/FoodTrackerServer/.build/debug/FoodTracker`  
    or using the hosted instance in the IBM Cloud
2. Open the Kitura monitoring dashboard (/swiftmetrics-dash)
3. Launch the FoodTracker app and add or remove a Meal entry
4. View the monitoring panel to see the responsiveness of the API call
5. Check the data has been persisted by the Kitura server
    1. Go the to REST API explorer:    http://localhost:8080/explorer/
    2. From the Kitura REST API explorer select “GET /ServerMeals”
    3. Press the “Try it out!” button
    4. Check for a response body that contains data and a Response Code of 200

**Add a Web Application to the Kitura server**
1. Update the Kitura server application to save the received images to the local file system:
    1. Open the `Sources/Generated/ServerMealResource.swift` source file that contains the REST API routes
    2. Import Foundation:
    `import Foundation`
    3. Update the `handleCreate()` function to add the following after the `let model = try ServerMeal(json: json)` statement to save the images:
      ```
            let photoData = Data(base64Encoded: model.photo)
            let fileManager = FileManager.default
            let publicDirectory = fileManager.currentDirectoryPath + "/public/"
            fileManager.createFile(atPath: publicDirectory + model.name + ".jpg", contents: photoData)
      ```
    4. Add a `/public/jpeg.html` file containing: 
    `<img src="Caprese Salad.jpg">`
    5. Re-build and run the server
   
**Rerun the FoodTracker iOS App and view the Web App** 
1. Run the iOS app in XCode and add or remove a Meal entry
2. Visit the web application at to see the saved image:
`http://localhost:8080/jpeg.html`
