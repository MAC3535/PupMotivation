# PupMotivation

Description

An application created using DOG API and THEY SAID SO QUOTES API.

Within the application you can select from eight different Quote types. You then have to option to either choose from one of the preselected dog breeds, a random dog breed or have the option to search for a dog breed. A request is then sent to both THEY SAID SO QUOTES API and DOG API for the selected quote type and dog breed. Once that data is collected, an image view will be populated with an image of your selected dog breed, along side a quote of the day for your selected quote type.

How it was made

The project was created using Swift, UIKIT and Storyboards.
Two collection views were used to set up buttons for our Quote type and Dog Breed type.

Learning

-JSON parsing and working with data -Dispatch Groups - Concurency and Threading

In this project you get the chance to work with the multiple API requests. A dispatch group was implemented in order to handle the data retrieval and used to handle the transition to the next ViewController once all data has been returned. 

Final Thoughts

This project was a good dive into handling mutiple network calls.

