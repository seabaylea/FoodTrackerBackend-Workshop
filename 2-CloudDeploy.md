# Deloying to IBM Cloud

### Pre-Requisites:
**Create a free IBM Cloud Account**  
Go to the following URL, fill out the form and press "Create Account":  
https://console.bluemix.net/registration/?target=%2Fdashboard%2Fapps  

**Install the IBM Developer Tools**  
`curl -sL https://ibm.biz/idt-installer | bash`

**Obtain a GitHub ID**  
Go to the following URL, enter Username, Email and Password and press "Sign up for GitHub":  
https://github.com/
 
**Install the Git CLI**  
`brew install git`  




## Getting Started
There are two main methods to deploying your application to IBM Cloud:  
1. Using the IBM Developer Tools CLI  
2. Using the IBM Cloud DevOps pipelines  



### Option 1: IBM Developer Tools (IDT)
1. Go to the root directory of your FoodTrackerServer project
2. Log in to IBM Cloud  

    ```
    bluemix api https://api.ng.bluemix.net
    bluemix login
    bluemix target -o <YOUR_EMAIL> -s dev
    ```
where `YOUR_EMAIL` is the email address you used when signing up to IBM Cloud.  
3. Build and deploy your project

    ```
    idt build
    idt deploy
    ```

4. Copy and paste the URL for your deployed app into the browser to check that your server is running.

### Option 2: IBM Cloud DevOps Pipelines

In order to use the IBM Cloud DevOps pipelines to build, test and deploy your project, you need to host your project in a Git repositiory that is visible to IBM Cloud. The easiest way to do this is using GitHub.

#### Create a GitHub project
1. Go to your GitHub account  
   http://github.com
2. Go to your profile by clicking on your avatar in the top right hand corner.
3. Select the "Repositorites" tab 
4. Select the green "New" button
5. Give your repository a name and press "Create repository"  
**Note:** Keep this page for use later


#### Create a Local Git Project
1. Go to the root directory of your FoodTrackerServer project
2. Initialise a local git project
`git init`
3. Add all your files to the project
`git add -A`
4. Check those file in by as a "commit"
`git commit -m "Initial commit"` 
6. Push the commit to GitHub
Use the two lines under "…or push an existing repository from the command line" from the page dispalyed when you created your GitHub page.

7. Reload the GitHub project page

#### Create an IBM Cloud DevOps Toolchain for your project

1. Click the "Create Toolchain" button in the README.md of your GitHub project.
2. If needed, login to IBM Cloud using your credentials
3. Click the "Create" button
4. Click on the "Delivery Pipeline" tile
5. Wait for the "Deploy Stage" to complete
6. Click the link under "Last Execution Result" to check that the Kitura server is running once its status button turns green.


## Updating the FoodTracker iOS Application
Before the iOS applicaiton can use the cloud hosted server, it needs to be updated with the location of the server.
1. Open the FoodTracker applications Workspace (not project!):
```
cd ~/FoodTrackerBackend-Workshop/iOS/FoodTracker/
open FoodTracker.xcworkspace
```
2. Edit the `Pods > Development Pods > FoodTrackerServer_iOS_SDK > Resources > FoodTrackerServer_iOS_SDK.plist` file to set the hostname and port for the FoodTrackerBackend server (in this case to remove the port number and to point to the Bluemix host address):  
```
FoodTrackerServer_iOS_SDKHost = http://<bluemix_host_address>/api
```
3. Build and run the FoodTracker app in the iOS simulator and add or remove a Meal entry  
4. View the monitoring panel in the Kitura server to see the responsiveness of the API call  
5. Check the data has been persisted by the Kitura server  
    1. Go the to REST API explorer:    http://<bluemix_host_address>/explorer/  
    2. From the Kitura REST API explorer select “GET /ServerMeals”  
    3. Press the “Try it out!” button  
    4. Check for a response body that contains data and a Response Code of 200  
