# Rails Marketplace

## Short Answer Questions

### What is the need (i.e. challenge) that you will be addressing in your project?
People need a place to rent cheap snow gear.
Snow gear owners need a place to make extra money from unused items.

### Identify the problem you’re trying to solve by building this particular marketplace App? Why is it a problem that needs solving?
The average vacationer only uses their snow gear for a few days per snow season, yet it is an essential part of their experience. There is also a large supply of snow gear owned by individuals which is unused for the majority of the year. Additionally, rental gear found near ski resorts tend to be of varying quality. We are aiming to connect owners of unused gear with vacation-goers who prefer to rent higher quality privately owned equipment.

### Describe the project you will be conducting and how. your App will address the needs.
The project will be a two-sided marketplace that will allow users to rent other user's snow gear, and also list their own snow gear for other users to rent.
Renters will be able to search for all available gear based on the location of the renter, the desired pick-up and drop-off times.
Listers will be able to make a listing for their available gear with photos, gear specifications and additional information.

### Describe the network infrastructure the App may be based on.
Amazon AWS will be used to store images in an S3 Bucket.
Heroku is where the app will be deployed and the postgresql database stored.

### Identify and describe the software to be used in your App.
The App uses Ruby on Rails with a postgresql database.
Carrierwave gem used to allow uploading images to AWS S3 Bucket.
MiniMagick gem also used for processing images.
Devise gem used for user management.

### Identify the database to be used in your App and provide a justification for your choice.
Postgresql will be used for the database as it provides a lot of functionality.

### Identify and describe the production database setup (i.e. postgres instance).
Postresql database will be used in production as it is hosted by Heroku.
This will be a seperate database to development / testing.

### Describe the architecture of your App.

Browser <--> Web Server --> Controller <--> Model <--> Database
                ^              |
                |              v
                ------------- View

Our app utilises rail's web framework.
Users interface with our app via a web browser, with CRUD requests being sent through to our web server. We are currently using Puma as our web server. Puma interprets the requests and routes them through to our app's controller, Action Controller.

Rails employs a Model View Controller (MVC) architectural pattern. In accordance with the design principle of 'separation of concerns', each component (model, view and controller) handles a specific set of actions for our app.

As such, Action Controller handles the requests after determining which action to take from our controllers.

### Explain the different high-level components (abstractions) in your App.

### Detail any third party services that your App will use.
AWS - S3 Bucket used to store uploaded images.
Stripe - Used for taking payments from users.
Mailgun -
<!-- Google Maps API - Generating maps and location details. -->
### Describe (in general terms) the data structure of marketplace apps that are similar to your own (e.g. eBay, Airbnb).


### Discuss the database relations to be implemented.
We will be using two database relation types in our app.
- One to One
This is used when 1 record in 1 table relates to only one record in another table. To set this up in rails one model needs to be given a belongs_to relationship and the related model needs to be set to has_one. Example: One booking can only have one review
- One to Many
This relationship is used when a single record in one table has many related records in another table. This is achieved by using belongs_to and has_many in the rails models. Example: One user can have many listings.
- Many to Many
This relationship was not needed for our application. It allows for records in table A to have many related records in table B and vice versa. Example: A student can have many classes and classes can have many students.

### Describe your project’s models in terms of the relationships (active record associations) they have with each other.
- User Model
- Listing Model
- Booking Model
- Location Model
- ListingImage Model
- UnavailableDay Model

### Provide your database schema design.
![database schema image](http://i68.tinypic.com/rlgvtz.png)

### Provide User stories for your App.
* As a user I want to be able to sign up so I can rent and list gear.
* As a user I want to be able to login with my existing account.
* As a user I want to be able to retrieve my password if i've forgotten it.
* As a user I want to be to change my password.
* As a user I want to be able to find gear to rent based on location and specific dates so that I can find the gear I need.
* As a user I want to be able to list my gear with photos, pricing, specifications and information about my gear.
* As a user I want to be able to make and recieve payments after renting gear.
* As a user I want to be able to leave a review about my experience renting gear from another user.
* As a user I want to be able to edit my profile to change my photo and details.
* As a user I want to be able to view another user's profile to view their user rating, available listings and their reviews.
* As a user I want to be able to find the answer to frequently asked questions.
* As a user I want to be able to learn more about how the rental and listing process works.
* As a user I want to be able to contact Sloper through email or social media.

#### Stretch goals
* As a renter I want to be able to receive lister's confirmation before payment
* As a user I want to be able to reply to a review about me left by another user.
* As a user I want to be able to view a lister's last login to filter out inactive listings.
* As a user I want to be able to slide into another user's DMs.
* As a user I want to be able to filter my results based on specific item details.
* As a user I want to see where the item is located on a map.

### Provide Wireframes for your App.
![landing page wireframes](https://imgur.com/JNqoeMJ.png)
![login screen wireframes](https://imgur.com/O1rGJ77.png)
![sign-up screen wireframes](https://imgur.com/CniTPiY.png)
![forgot password screen wireframes](https://imgur.com/yTJFJsg.png)
![listings page wireframes](https://imgur.com/7U3lMzz.png)
![show listing screen wireframes](https://imgur.com/l2aRpqZ.png)
![profile screen wireframes](https://imgur.com/CSGyBOG.png)

### Describe the way tasks are allocated and tracked in your project.
Trello will be used for project management. As all of our tasks are listed in our Trello backlog, we assigned progress-critical work between ourselves and prioritised that while pulling whatever else we wanted to do next down from the backlog to our current sprint. Tracking is done via Trello as well, as tasks go through the phases Work-in-progress, In Review and Done throughout the task's lifecycle.

### Discuss how Agile methodology is being implemented in your project.
As per agile methodology, we broke down the entire assessment into small user stories, which were then sorted by importance on Trello. We assigned tasks based on what needed to be completed next and added them to our current sprint, which would then be gradually completed throughout the day. Completed tasks would be put into review, and if everything was fine it would be marked as done. If the task remained incomplete, we would discuss it during our standup the next morning regarding difficulties and whether it needed to be broken down due to unforseen work, before being reassigned and worked on again.

### Provide an overview and description of your Source control process.
Each team member will be working collaboratively on the same git repo hosted by GitHub.
Seperate branches will be used by each person and pull requests used to merge them together.
One team member will be in charge of all pull requests and merging.
SourceTree and GitKraken is used to make this process easier by provide a GUI for git related commands and keeping track of repo visually.

### Provide an overview and description of your Testing process.
After pulling from our development branch to our local branch before pushing to github, we would test the newest changes added by other team members between our pulls.
We also maintained a google spreadsheet with test cases, expected results and actual results for each user action on the site. This was tested before deploying to Heroku.

### Discuss and analyse requirements related to information system security.
### Discuss methods you will use to protect information and data.
### Research what your legal obligations are in relation to handling user data.

