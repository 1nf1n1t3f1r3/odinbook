# README

Github Page for The Odin Project (TOP) Odinbook.
The Website can be found at this URL:
https://mysite-xb3v.onrender.com/

If it doesn't work and you want to see it, let me know. The welcoming E-Mail may have broken after 15/06/2026, due to working with a Sendgrid Trial, at the moment.

## Summary

The project is a pretty generic social media clone. Users can sign up with an Email + Username through Devise. User will receive a welcome mail. Users can write Posts, which accept Text and Images, can Comment on Posts, Like Posts and follow other Users. Users can also set a Profile Picture

## TOP Info

The TOP Project can be found at this URL (May require Login):
https://www.theodinproject.com/lessons/ruby-on-rails-odin-book

### TOP Project Requirements:

Use PostgreSQL for your database from the beginning (not SQLite3), that way your deployment will go much more smoothly.
Users must sign in to see anything except the sign in page.
User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast on Devise (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
Users can send follow requests to other users.
Users can create posts (begin with text only).
Users can like posts.
Users can comment on posts.
Posts should always display the post content, author, comments, and likes.
There should be an index page for posts, which shows all the recent posts from the current user and users they are following.
Users can create a profile with a profile picture. You may be able to get the profile picture when users sign in using OmniAuth. If this isn’t the case you can use Gravatar to generate the photo.
A user’s profile page should contain their profile information, profile photo, and posts.
There should be an index page for users, which shows all users and buttons for sending follow requests to users the user is not already following or have a pending request.
Set up a mailer to send a welcome email when a new user signs up. Use the Letter Opener gem to test it in development mode.
Deploy your App to a hosting provider.
Set up an email provider and start sending real emails.
Extra credit
Make posts also allow images (either just via a URL or, more complicated, by uploading one).
Use Active Storage to allow users to upload a photo to their profile.
Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
Style it up nicely! We’ll dive into HTML/CSS in the next course.

## Project Screenshots

### The Main Page at Posts/Index:

<img width="1918" height="1033" alt="Screenshot from 2026-04-16 20-52-10" src="https://github.com/user-attachments/assets/08dedf21-5a6c-472a-a7da-e61de6169064" />

### List of Users:

<img width="1918" height="1033" alt="Screenshot from 2026-04-16 20-54-27" src="https://github.com/user-attachments/assets/e90df81a-ddb0-4ad2-b375-99d8f6640918" />

### Post View: 

<img width="1918" height="1033" alt="image" src="https://github.com/user-attachments/assets/10daff4e-f6cb-4360-9dd7-cd6513157040" />

My Image broke in this post because it didn't have persistent storage yet, but shoutout to @purple for dropping a comment :) 






