# Requirements

In this document you will find all the initial features we want the backend to have. Think of this as a stake in the ground, our MVP is delivering what is defined in this document. Some information on the Meetup API can be found [here](https://www.meetup.com/meetup_api/docs/)

- Comments
    - Should expose an endpoint to *create* a comment
    - Should expose an endpoint to *update* a comment
    - Should expose an endpoint to *delete* a comment
    - Should expose an endpoint to get all comments for a specific Meetup

- Meetups
    - Should get all past Meetups from the Meetup.com API, and save them in our database (backfilling)
    - When a Meetup is made (via Meetup.com) we should create a Meetup in our App, and it should be in the "future" meetups list

- Analytics
    - Should expose an endpoint to get the most popular past Meetup (based on number of comments?)
