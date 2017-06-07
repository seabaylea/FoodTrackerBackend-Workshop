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

**Install CouchDB (Optional)** 
1. Install from Homebrew:  
`brew install couchdb`
2. Start couchdb:  
`couchdb`

**Download the FoodTracker App project:** 
1. Download the app from the following link:  
https://developer.apple.com/sample-code/swift/downloads/09_PersistData.zip

**Install the IBM Cloud command line tools**  
1. Install the CLI from:  
http://clis.ng.bluemix.net/ui/home.html
2. Install the SDK generation plugin:  
`bluemix plugin install sdk-gen -r Bluemix`

## Getting Started
**1. Run the Food Tracker App:**  
1. Unzip the FoodTracker App (09_PersistData.zip) into a suitable directory:  
```
mkdir -p ~/KituraLab/iOS
cp -rf ~/Downloads/09_PersistData/ ~/KituraLab/iOS/
cd ~/KituraLab/iOS/FoodTracker
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
mkdir ~/KituraLab/Server
cd ~/KituraLab/Server
```
2. Run Swift Server Generator:
```
yo swift server
What's the name of your application? > FoodTracker
Enter the name of the directory to contain the project: FoodTracker
```
Select a type of project. Starter allows you to create general Basic, Web or Backend for Frontend project, including creating REST APIs, whereas a Create Read Update Delete (CRUD) project if designed to do data persistance. Select a CRUD application.
```
Select type of project: 
  Scaffold a starter 
❯ Generate a CRUD application
Select capabilities: (Press <space> to select, <a> to toggle all, <i> to inverse selection)
❯◉ Embedded metrics dashboard
 ◉ Docker files
 ◉ Bluemix cloud deployment
```
Select a datastore. Use Cloudant if you have CouchDB installed and running, or Memory if you do not:
```
Select data store: 
  Memory (for development purposes) 
❯ Cloudant / CouchDB
Generate boilerplate for Bluemix services: 
❯◉ Auto-scaling
Configure service credentials (leave unchecked for defaults): (Press <space> to select, <a> to toggle all, <i> to inverse selection)
❯◯ Cloudant / CouchDB
```
3. Add a data model to persist to the datastore
```
cd ~/KituraLab/Server/FoodTracker
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
`open FoodTracker.xcodeproj`
    2. Edit the scheme and select a Run Executable of “FoodTracker”
    3. Run the project

5. Check the FoodTracker server URLs are running:
    * Kitura Homepage: http://localhost:8080
    * Kitura Monitoring: http://localhost:8080/swiftmetrics-dash/
    * Kitura REST API: http://localhost:8080/explorer/

6. Test the REST API is running correctly
    1. From the Kitura REST API explorer select “GET /ServerMeals”
    2. Press the “Try it out!” button
    3. Check for an empty response body (“[]”) and a Response Code of 200


**Push the Project to GitHub (Optional)**
1. Initialize a local git project and add the Kitura server application to it:
```
    git init
    git add -A
    git commit -m "Initial commit"
```    
2. Create a project in your Git repository by clicking on the New button in the following URL:
    1. https://github.com/[GitHub Username]?tab=repositories
    2. Give the project a name of FoodTracker
3. Push your files to the GitHub repo:
    1. git remote add origin https://github.com/[GitHub Username>]/FoodTracker.git
    2. git push -u origin master

**Create a delivery toolchain to host the application on the IBM Cloud (Optional)**
1. Visit the project in GitHub: https://github.com/[GitHub Username]/FoodTracker  
If you didn't create your own Git project, go to https://github.com/seabaylea/FoodTracker and "fork" that repo into your space.
2. Click on the “Create Toolchain” button
3. Select the “Track deployment of code changes” check box and click “Create”
4. Click on the “Delivery Pipeline” to see the state of the application being deployed


**Create an iOS SDK to call the Kitura Server Application:**
1. Run the SDK generator:  
`bluemix sdk generate ./Server/FoodTracker/definitions/FoodTracker.yaml --ios`
2. Unzip the downloaded package:  
`unzip FoodTracker.zip`
3. Follow the documentation to install the SDK into the FoodTracker iOS app  
`open FoodTracker/Docs/README.html`

**Update FoodTracker to call the iOS SDK APIs:**
1. Open the FoodTracker app project:
```
cd ~/KituraLab/iOS/FoodTracker/
open FoodTracker.xcworkspace
```
2. Edit MealTableViewController.swift
    1. Add `import Foundation`
    2. Add the following as the start of the sameMeals() function:
```
            for meal in meals {
                  saveToServer(meal: meal)
              }
```
3. Add the following function to the MealTableViewController class
```
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
4. Add the following extension to the Meal model at the end of the file:
```
    extension Meal {
    func asServerMeal() -> ServerMeal {
        let serverMeal = ServerMeal()
        serverMeal.id = "1"
        serverMeal.name = self.name
        serverMeal.photo = UIImageJPEGRepresentation(self.photo!, 0)?.base64EncodedString()
        serverMeal.rating = Double(self.rating)
        return serverMeal
    }
}
```
3. Edit the `Pods/FoodTrackerConfig.plist` file to point to the Kitura Server:  
`FoodTrackerHost = http://localhost:8080/api`  
(or the location of your hosted Kitura instance in the IBM Cloud)

**Run the FoodTracker app with storage to the Kitura server**
1. Make sure the Kitura server is running
Either by running  
`~/KituraLab/Server/FoodTracker/.build/debug/FoodTracker`  
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
