# Rails Marketplace

### Live Site
[Heroku Link](https://sloper.herokuapp.com)
### GitHub Repo
[GitHub Link](https://github.com/dav-armour/sloper)

<!-- TO DO list (PLEASE DELETE AS U COMPLETE THEM)
Design documentation including,
Design process
User stories
A workflow diagram of the user journey/s.
Wireframes
Database Entity Relationship Diagrams
Details of planning process including,
Project plan & timeline
Screenshots of Trello board(s)
-->

### Project Description

This project aims to create a two sided marketplace where people can rent unused snow gear from the many people that own gear and do not use it for the majority of the year.
This will allow snow gear owners to earn extra money by putting their unused assets to good use.
Most rental gear that is available in normal shops are of bad quality from the lack of care and high use of each item. They also use cheaper components than someone would buy for themselves.

### Functionality / features
- Multiple users supported with personal profiles that can be edited.
- User profile page shows all the listings of that user and average rating of all the user's listings.
- Ability to upload profile image that is used throughout the site.
- Can create new listings to be able to rent out ski or snowboards. These can be later edited or deleted.
- Ability to upload multiple images for each listing. Shown using a carousel on the listing page.
- Can book a rental using stripe payments that allows refunding / cancelling of future dates.
- Allows for rating of each listing after the rental period has finished. Author of review has option to edit or delete.
- A lister can also choose to refund any booking if needed.
- Shows all reviews of each listing and user including average rating to help with selection.
- Can track all your bookings that include both as a renter and a lister.
- Can filter listings based on city, available dates, category, type, size and brand.
- Uses pagination to limit how many listings are shown per page. Can change the limit amount.
- Responsive website design to allow for all screen sizes.

### Screenshots
#### Landing Page
![landing page screenshot](http://i66.tinypic.com/ngyq8h.png)
#### Listing Index / Search Page
![listings index screenshot](http://i68.tinypic.com/2a4v1h5.png)
#### My Bookings Page
![my bookings screenshot](http://i66.tinypic.com/9gvshz.png)
#### Listing Reviews
![listing reviews screenshot](http://i63.tinypic.com/2qv4m8k.png)
#### New Listing Form
![new listing screenshot](http://i64.tinypic.com/2bxsoh.png)
#### Rental Booking Page
![rental page screenshot](http://i64.tinypic.com/1zoi0bc.png)
#### Profile Page
![profile page screenshot](http://i63.tinypic.com/fn4ob8.png)

### Tech stack (e.g. html, css, deployment platform, etc)
- HTML5
- CSS3
- Javascript / JQuery
- Ruby on Rails
- Bootstrap 4
- Heroku
- AWS - S3 Bucket

### Instructions on how to setup, configure and use your App.
1. Clone this git repository

```
git clone https://github.com/dav-armour/sloper
```
2. Navigate into directory
```
cd sloper
```
3. Install required gems
```
bundle install
```
4. Create database, run migrations and seed database with sample data.
```
rails db:setup
```
Optional: If you do not want seed data
```
rails db:create
rails db:migrate
```
5. Start the rails server
```
rails s
```
6. Open web browser and goto http://localhost:3000

## Design Documentation

### Design Process
Initially, we did some research into existing rental product p2p apps to draw UI inspiration. Due to budget and time constraints, we did very little (read: none) external research into user pain points. Looking at competitor offerings,we determined that it was essential to allow the user to search for items on the landing page, for that is the main reason why users would visit the site.

We then designed the wireframes for the site look on Balsamiq, before working on our ERD.

We then looked through colour inspo. Our colour inspo board can be found here: ![colours moodboard](https://pollunit.com/en/polls/ViQdBCsrCU_O1RCSpGxSGA).

We reiterated over the ERD, wireframes and site colours multiple times over the course of the assessment.

### User Stories
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
* As a user I want to be able to filter my results based on specific item details.
* As a user I want to be able to view a lister's last login to filter out inactive listings.

### User journey workflow diagram
![Link to User journey workflow diagram](https://drive.google.com/open?id=1ZxWKv6rfBLRKLXniUFDshcGA-UQdhR74)

### Wireframes

### Database Entity Relationship Diagram
[Link to ERD (Open with Draw.io)](https://drive.google.com/open?id=1m7_Sz9i8pdh3QcPdqbcF39FfrjUe6NsY)

### Trello Board
[Link to board](https://trello.com/b/SMIF5bUm/sloper)
![trello board screenshot](http://i63.tinypic.com/dom99f.png)

## Short Answer Questions

#### 1. What is the need (i.e. challenge) that you will be addressing in your project?
People need a place to rent cheap snow gear.
Snow gear owners need a place to make extra money from unused items.

#### 2. Identify the problem you’re trying to solve by building this particular marketplace App? Why is it a problem that needs solving?
The average vacationer only uses their snow gear for a few days per snow season, yet it is an essential part of their experience. There is also a large supply of snow gear owned by individuals which is unused for the majority of the year. Additionally, rental gear found near ski resorts tend to be of varying quality. We are aiming to connect owners of unused gear with vacation-goers who prefer to rent higher quality privately owned equipment.

#### 3. Describe the project you will be conducting and how. your App will address the needs.
The project will be a two-sided marketplace that will allow users to rent other user's snow gear, and also list their own snow gear for other users to rent.
Renters will be able to search for all available gear based on the location of the renter, the desired pick-up and drop-off times.
Listers will be able to make a listing for their available gear with photos, gear specifications and additional information.

#### 4. Describe the network infrastructure the App may be based on.
Amazon AWS will be used to store images in an S3 Bucket. Heroku is where the app will be deployed and the postgresql database stored. Heroku is a cloud platform used to host web applications. It provides our website with a domain name and DNS to allow people to access our site.

#### 5. Identify and describe the software to be used in your App.
The App uses Ruby on Rails with a postgresql database.
Carrierwave gem used to allow uploading images to AWS S3 Bucket.
MiniMagick gem also used for processing images.
Devise gem used for user management.

#### 6. Identify the database to be used in your App and provide a justification for your choice.
PostgreSQL will be used for the database as it provides a lot of functionality. In comparison with SQLite, the default database management system bundled with Rails, PostgreSQL provides the critical ability to perform multiple writes into the server at the same time. Also, since PostgreSQL is widely adopted, open-source and completely SQL standards-compliant, searching for solutions for our app would be much easier. In particular there were a few functions of PostgreSQL that we used extensively throughout our site:
* Nested querying
* Eager loading
* Fuzzy searching

#### 7. Identify and describe the production database setup (i.e. postgres instance).
Postresql database will be used in production as it is hosted by Heroku.
This will be a seperate database to development / testing.

#### 8. Describe the architecture of your App.
Our app is structured as a layered, multi-tiered architecture in the form of the MVC framework. This can be separated into the presentation layer (view), logic layer (controller) and the data layer (model).
At the core is our data layer (model), which stores and retrieves information using a database.
This information is both provided and requested for by our logic layer (controller), which handles basically all of the calculations and decision-making for our app. The controller is also responsible for moving data to and from our model and view.
Our presentation layer (view) is responsible solely for interacting with the user by transforming data from the controller into a user-friendly interface.
Additionally, our app utilises rail's web framework.
Users interface with our app via a web browser, with CRUD requests being sent through to our web server. We are currently using Puma as our web server. Puma interprets the requests and routes them through to our app's controller, Action Controller. Ultimately, when data is returned from our view it is sent through to the web server before being passed on to the user's browser.

#### 9. Explain the different high-level components (abstractions) in your App.
Rails employs a Model View Controller (MVC) architectural pattern. In accordance with the design principle of 'separation of concerns', each component (model, view and controller) handles a specific set of actions for our app.

As such, Action Controller handles the requests after determining which action to take from our controllers. Our controllers communicates with both our view and model components.

Rails uses Active Record in the model layer. It is responsible for creating and maintaining persistent data required for our app by interacting with our database. We used a PostgreSQL database as it allows for multiple writes simultaneously.

Minimal logic is present in our view layer, which takes data instantiated by our controllers, transforms it and applies a layout before sending it to our web server, Puma, which ultimately passes the end result to the user's browser.

#### 10. Detail any third party services that your App will use.
- AWS - S3 Bucket used to store uploaded images.
- Stripe - Used for taking payments from users.
- Mailgun - Transactional email API for generating forgotten password emails

#### 11. Describe (in general terms) the data structure of marketplace apps that are similar to your own (e.g. eBay, Airbnb).
In essence, we are a peer-to-peer product rental app, and thus our data structure resembles other product rental apps such as ToolMates for tool renting, Spinlister for bike lending and Turo for car renting. Users can sign up with the personal information and have the ability to both add new products as well as search through and access products listed by other users. Once a booking is confirmed, the booking details are stored in the database and the product is unavailable during that timeframe.

#### 12. Discuss the database relations to be implemented.
We will be using two database relation types in our app.
- One to One
  - This is used when 1 record in 1 table relates to only one record in another table. To set this up in rails one model needs to be given a belongs_to relationship and the related model needs to be set to has_one. Example: One booking can only have one review
- One to Many
  - This relationship is used when a single record in one table has many related records in another table. This is achieved by using belongs_to and has_many in the rails models. Example: One user can have many listings.
- Many to Many
  - This relationship was not needed for our application. It allows for records in table A to have many related records in table B and vice versa. Example: A student can have many classes and classes can have many students.

#### 13. Describe your project’s models in terms of the relationships (active record associations) they have with each other.
- User Model - Stores user information
  - Has many Listings
  - Has many Bookings
- Listing Model - Stores details of each listing
  - Has many Bookings
  - Has many Renters through Bookings
  - Has many Listing Images
  - Has many Unavailable Days
  - Has one Location
- Booking Model - Stores transactions when user rents a listing
  - Belongs to User
  - Belongs to Listing
  - Has one Review
- Location Model - Stores geo data of listing location
  - Belongs to Listing
- ListingImage Model - Stores all uploaded images of the listing
  - Belongs to Listing
- UnavailableDay Model - Keeps track of what days each listing has been rented
  - Belongs to Listing
- Review Model - Users can leave a review after renting an item.
  - Belongs to Booking
  - Has one User through Booking

#### 14. Provide your database schema design.
![database schema image](http://i68.tinypic.com/rlgvtz.png)
[Link to ERD (Open with Draw.io)](https://drive.google.com/open?id=1m7_Sz9i8pdh3QcPdqbcF39FfrjUe6NsY)

#### 15. Provide User stories for your App.
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
* As a user I want to be able to filter my results based on specific item details.
* As a user I want to be able to view a lister's last login to filter out inactive listings.

##### Stretch goals
* As a renter I want to be able to receive lister's confirmation before payment
* As a user I want to be able to reply to a review about me left by another user.
* As a user I want to be able to slide into another user's DMs.
* As a user I want to see where the item is located on a map.

#### 16. Provide Wireframes for your App.
![landing page wireframes](https://imgur.com/JNqoeMJ.png)
![login screen wireframes](https://imgur.com/O1rGJ77.png)
![sign-up screen wireframes](https://imgur.com/CniTPiY.png)
![forgot password screen wireframes](https://imgur.com/yTJFJsg.png)
![listings page wireframes](https://imgur.com/7U3lMzz.png)
![show listing screen wireframes](https://imgur.com/l2aRpqZ.png)
![profile screen wireframes](https://imgur.com/CSGyBOG.png)

#### 17. Describe the way tasks are allocated and tracked in your project.
Trello will be used for project management. As all of our tasks are listed in our Trello backlog, we assigned progress-critical work between ourselves and prioritised that while pulling whatever else we wanted to do next down from the backlog to our current sprint. Tracking is done via Trello as well, as tasks go through the phases Work-in-progress, In Review and Done throughout the task's lifecycle.

#### 18. Discuss how Agile methodology is being implemented in your project.
As per agile methodology, we broke down the entire assessment into small user stories, which were then sorted by importance on Trello. We assigned tasks based on what needed to be completed next and added them to our current sprint, which would then be gradually completed throughout the day. Completed tasks would be put into review, and if everything was fine it would be marked as done. If the task remained incomplete, we would discuss it during our standup the next morning regarding difficulties and whether it needed to be broken down due to unforseen work, before being reassigned and worked on again.

#### 19. Provide an overview and description of your Source control process.
Each team member will be working collaboratively on the same git repo hosted by GitHub.
Seperate branches will be used by each person and pull requests used to merge them together.
One team member will be in charge of all pull requests and merging.
SourceTree and GitKraken is used to make this process easier by provide a GUI for git related commands and keeping track of repo visually.

#### 20. Provide an overview and description of your Testing process.
After pulling from our development branch to our local branch before pushing to github, we would test the newest changes added by other team members between our pulls.
We also maintained a google spreadsheet with test cases, expected results and actual results for each user action on the site. This was tested before and after deploying to Heroku.
All forms were tested with valid and invalid data to ensure that errors were handled correctly and no unauthorised actions could be taken.
[Link to spreadsheet](https://drive.google.com/open?id=1999qabZM2Xg4i4eZ0C4PqjEPDqXPOi9hlOD8Vpik8DA)

#### 21. Discuss and analyse requirements related to information system security.
1. Webpage form inputs must be sanitised or validated before being passed through to the database as malicious code in the form of an SQL injection can both harm the database and retrieve database information.
2. Passwords cannot be stored as plain text for a website as it is not secure. Any user with access to the database can also access all passwords stored on the site. The most common form of security for a password is hashing the password.
3. Any transmission or storage of payment data must be subject to the most stringent security available as it is extremely sensitive data. There are multiple technologies that have become the standard to ensure secure payment processing. these include TLS (transport layer security), PCI (Payment Card Industry) compliance, and tokenisation of ID authentication.

#### 22. Discuss methods you will use to protect information and data.
1. To protect against SQL injection attacks, we validate our form fields, as well as sanitizing our parameters before they are passed to the model.
2. The use of Rails ORM when querying the database also stops any potential SQL injection.
3. Rails forms also use a CSRF token that stops any attempts at cross-site forgery requests.
4. Using Devise's default settings, all user passwords are hashed using BCrypt.
5. Our app neither handles nor stores payment data. All payments go through Stripe, which forces TLS encryption, PCI DSS and tokenisation. Our app only store the payment ID in our database as a payment reference.

#### 23. Research what your legal obligations are in relation to handling user data.
As per Australia's privacy laws, and in accordance with Google's requirements, our website needs to include a privacy policy. For each piece of personal information, we would need to include:
* the type of data
* our purpose for the data
* how we collect and store the data securely
* a promise to not disclose emails
* how a user can access, change and remove data
* whether data is disclosed to other parties
* our contact details
* privacy complaint handling