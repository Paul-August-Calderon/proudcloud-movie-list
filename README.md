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
- I would clarify with UI/UX designer and/or PO about "Vote Rating" in the mockup vs "Vote Average" in the AC. For now I'm assuming the mockup's "Vote Rating" is to be followed  
- I would clarify with UI/UX designer and/or PO if there should be an empty state for the search results. For now I'm assuming there shouldn't be. This patterns off Youtube's search. 
- I would clarify with PO if displayed movies shouldn't be shown on the search results.  For now I'm assuming they shouldn't be  
- I would clarify with PO how to handle movies that have the same vote average when it comes to the green highlight. For now I'm letting tied movies all get highlighted. If we don't want this behavior, we can take into account the vote count as well.
- I would raise the possibility of splitting this story into 2. 1st for implementing the initial layout and 2nd for implementing the search functionality. This depends on how long sprints are in the workflow.
---
Assumptions/liberties taken:  
The movie list will be the root of the site  
I would assume that we are implementing a new feature for an already existing project thus no subtask for creating and setting up a new rails app.  
The database already has the data thus no sub tasks for inserting the data.
The application will use SQLite to reduce complexity.
The repository will have a copy of the sqlite database. 
---
Potential improvements:
Technical:
Generate database via seeds instead of using the db in the repo.
Refactor stimulus controller to be more resuable.
Create CRUD endpoints for movies.
More tests.
UI/UX:
Add a hover on highlight to the search results.
Add animations on adding/removing movies from list.

## Application Readme
