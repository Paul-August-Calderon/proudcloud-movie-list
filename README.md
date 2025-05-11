# README
This serves as the submission for Proudcloud's Technical Assessment.  
This readme starts with the "Planning" section that contains details how this feature might be broken down into subtasks.  
It also contains assumptions during the creation and some comments regarding the AC. 
### Planning
#### Subtasks
- Create route for movie list index
- Create MoviesController to handle requests to route.
- Implement header with app title and search box ( placeholder at this stage )
- Create row element to display movie title, vote rating and vote count and x button.
- Show 3 movies on initial page load.
- Implement 3 randomized movies upon load/refresh
- implement green highlight for row with highest rated movie
- implement removing a row upon clicking [X] icon.
- Implement search box to show a filtered list of movies as user types.
- create endpoint to receive form submission via stimulus
- submit search via stimulus
- create UI for autocomplete search results
- turbo stream in response to form submission
- implement clicking search results adds it to movie list
- Clicking away from the search box hides search results
- Ensure search doesn't show already listed movies
- Display nothing when no movie is matched. (should be clarified with PO)
- Ensure displayed and newly clicked/added movies don't show in the searched list (should be clarified with PO)
- Create tests
- QA/PO Verification
- UI/UX Verification
- Refactor
- Deployment
- Prod testing
---
#### Clarifications
- I would clarify with UI/UX designer and/or PO about "Vote Rating" in the mockup vs "Vote Average" in the AC. For now I'm assuming the mockup's "Vote Rating" is to be followed  
- I would clarify with UI/UX designer and/or PO if there should be an empty state for the search results. For now I'm assuming there shouldn't be. This patterns off Youtube's search. 
- I would clarify with PO if displayed movies shouldn't be shown on the search results.  For now I'm assuming they shouldn't be  
- I would clarify with PO how to handle movies that have the same vote average when it comes to the green highlight. For now I'm letting tied movies all get highlighted. If we don't want this behavior, we can take into account the vote count as well.
- I would raise the possibility of splitting this story into 2. 1st for implementing the initial layout and 2nd for implementing the search functionality. This depends on how long sprints are in the workflow.
---
#### Assumptions/liberties taken:  
- The movie list will be the root of the site  
- I would assume that we are implementing a new feature for an already existing project thus no subtask for creating and setting up a new rails app.    
- The database already has the data thus no sub tasks for inserting the data.  
- The application will use SQLite to reduce complexity.  
- The repository will have a copy of the sqlite database.   
---
#### Potential improvements:  
##### Technical:  
- Generate database via seeds instead of using the db in the repo.
- Use a different database than SQLite.
- Refactor stimulus controller to be more reusable.
- Cookies instead of hidden inputs can be used to track the listed movies.
- The current implementation won't properly handle a large amount of movies.
- Create CRUD endpoints for movies.
- Define expected behavior for tied movies. The current behavior is pretty iffy.
- Constrain movie titles to be unique.
- More tests.
##### UI/UX:
- Add a hover on highlight to the search results.
- Create an actual Homepage for the root path.
- Use an actual icon for the [X] button.

## ↓ Application Readme ↓
# Movie List Project
This application is implemented using Ruby On Rails.  
Intended as a code exercise for ProudCloud.  
# Overview
- [Installation](#installation)
- [Usage](#usage)
- [Implementation](#implementation)
- [Testing](#testing)
- [Deployment](#deployment)
## Installation
The project was developed under the following versions:
>Ruby 3.3.8  

>Rails 8.0.2  

*It is recommended to install the ruby version using a version manager(rbenv)*

##### To run the project locally
Clone the repository (you might need to be added as collaborator):
```bash
git clone https://github.com/Paul-August-Calderon/proudcloud-movie-list.git  
```
OR
```bash
gh repo clone Paul-August-Calderon/proudcloud-movie-list
```
Navigate to the project root
```bash
cd proudcloud-movie-list
```
and install the gems
```bash
bundle install
```
You can now try running the application via:
```bash
bin/rails server
```
##### Additional instruction for Development setup
There is an included Procfile.dev for running the project locally.  
If you have foreman, navigate to the root of the project and run:
```bash
foreman start -f Procfile.dev
```
Alternatively you can just execute the commands in the procfile individually.
```bash
bin/rails server -p 3000
```
```bash
bin/rails tailwindcss:watch
```
tailwindcss:watch allows you to keep your stylesheets updated while developing locally.

## Usage
To run the server locally:
```bash
bin/rails server
```
You can now access the application at:
> http://127.0.0.1:3000/  

The root of the application points to movies/
#### Endpoints
```
1. /movies       | GET 
```
For now, there is a single endpoint to the application.
### /movies
This endpoint displays three random movies from the database.  
Each movie row displays the title, vote rating, vote count and an [X] button.  
The highest rated movie is highlighted in green.  
There is a search bar on the upper right.  
#### Features:
- Clicking on the [X] removes the movie from the list.
- The search bar matches using the movie title. The results are displayed below.
- Clicking on a search result adds the movie to the list.
- Movies already listed don't get matched.
- The green highlight dynamically changes whenever a movie is added/removed from the list.
- Clicking anywhere other than the search bar and result, hides the search result.

## Implementation
The project uses Ruby and Ruby On Rails to develop the application.
#### Models
- ###### Movies
    -   id | Primary Key
    -   title | String | Null = False
    -   vote_average | Float | Null = False, Must be greater than 0 
    -   vote_count | Integer | Null = False, Must be greater than 0
#### Javascript
  - Javascript/Stimulus is used to implement most of the client-side behavior seen.
  - Typing in the search bar causes the form to be submitted.
  - There is a 300ms debounce when typing in the search bar.
  - Hidden inputs in the form keep track of the listed movies. This is used to exclude movies from the search result. 
  - A mutation observer is used to implement the row dynamic highlighting.
#### Turbo
  - A turbo stream, in response to the form submission, is responsible for delivering the search result. 

## Testing
This application uses rspec as the test runner.

The tests are located at spec/

You can run all the tests by running the command:
```
bundle exec rspec
```
To only run a specific test
```
bundle exec rspec spec/models/movie_spec.rb
bundle exec rspec spec/requests/movies_spec.rb
bundle exec rspec spec/system/movies_list_spec.rb
```

## Deployment
The project is deployed on Koyeb using their Hobby Plan resources.

The Hobby tier deployment hibernates when no traffic is detected. 
When first accessing the site, allow some time for the application to spin up.

[Link to deployed project](https://lucky-chinchilla-sandbox-mamon-2b375214.koyeb.app/)