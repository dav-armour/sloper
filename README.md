# Rails Marketplace

## Short Answer Questions

### What is the need (i.e. challenge) that you will be addressing in your project?
People need a place to rent cheap snow gear.
Snow gear owners need a place to make extra money from unused items.
### Identify the problem you’re trying to solve by building this particular marketplace App? Why is it a problem that needs solving?
The average vacationer only uses their snow gear for a few days per snow season, yet it is an essential part of their experience. Additionally, there is a large supply of snow gear owned by individuals which is unused for the majority of the year. Rental gear found near ski resorts tend to be of sub-par quality. We are aiming to connect owners of unused gear with vacation-goers who prefer to rent higher quality privately owned equipment.
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
### Explain the different high-level components (abstractions) in your App.
### Detail any third party services that your App will use.
AWS - S3 Bucket used to store uploaded images.
Stripe - Used for taking payments from users.
Google Maps API - Generating maps and location details.
### Describe (in general terms) the data structure of marketplace apps that are similar to your own (e.g. eBay, Airbnb).


### Discuss the database relations to be implemented.


### Describe your project’s models in terms of the relationships (active record associations) they have with each other.
### Provide your database schema design.

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
* As a user I want to be able to reply to a review about me left by another user.
* As a user I want to be able to view a lister's last login to filter out inactive listings.
* As a user I want to be able to slide into another user's DMs.
* As a user I want to be able to filter my results based on specific item details.
* As a user I want to see where the item is located on a map.

### Provide Wireframes for your App.

### Describe the way tasks are allocated and tracked in your project.
Trello will be used for project management.

### Discuss how Agile methodology is being implemented in your project.
### Provide an overview and description of your Source control process.
Each team member will be working collaboratively on the same git repo hosted by GitHub.
Seperate branches will be used by each person and pull requests used to merge them together.
One team member will be in charge of all pull requests and merging.
SourceTree app is used to make this process easier by provide a GUI for git related commands and keeping track of repo visually.
### Provide an overview and description of your Testing process.
### Discuss and analyse requirements related to information system security.
### Discuss methods you will use to protect information and data.
### Research what your legal obligations are in relation to handling user data.

