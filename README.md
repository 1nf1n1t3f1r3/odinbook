# README

Github Page for The Odin Project (TOP) Odinbook.
The Website can be found at this URL:
https://odinbook.janusdevries.nl/

## Summary

The project is a Facebook clone. Users can sign up with an Email + Username through Devise. Users can write Posts, which accept Text and Images, can Comment on Posts, Like Posts and follow other Users. Users can also set a Profile Picture

## TOP Info

The TOP Project can be found at this URL:
https://www.theodinproject.com/lessons/ruby-on-rails-odin-book

## Thoughts on the Building Process

It's been a little while since I actually wrote this stuff, but here's some things that stood out to me while building.

### Devise

After the Rails setup, the first step was to add Devise. I had to fight that mental model a little bit. Devise is a bit strange in that it adds its own User model and it places its routes in a different setup from what I seemed 'default' to me. But.. What can you do. Not overthinking it and just moving on is probably the best solution. The good thing about Rails is that things just work, even if you don't always understand why.

### User Controller & Post Model

Added the User Controller with Index and Show next. These'd later become the Users and Profile page, though I didn't really think about it like that at the time. A \_header component allows for basic navigation. The Post Model was next. It belongs to User, so Posts also got added to User/Show. Adding a Controller and seeding some Users/Posts, it's starting to look like something.

### Tailwind

Somehow I wound up with 6 Git Commits that are a variant of 'Adding Tailwind'. Tailwind is interesting. I like that you can store 'components' in the application.css file, then add those to the html, so you don't have to reinvent the wheel everywhere. That just leaves the class for deciding which Tailwind components to use, Flexboxing, colouring and font choices. It feels a lot easier to work with than dumping everything in a .css file, but it takes a while to figure out.

### Comments & Likes

Comments belong to Posts and to Users. So, that complicates the relationships a tiny bit. Other than that, not too special. There isn't an Index or Show on it, just a Create/Dextroy; Comments really just tag along on a Post with some string. They get shown under Posts's Show with a @post.comments.each kind of setup. Likes work similarly. if @post.liked_by?(current_user) -> show like, else show unlike; Create/Destroy buttons.

### Follows

I might have cheated a little bit in that Odinbook requested a Friend system, but I implemented a Follow system. My thinking is, if two people follow each other, that'd make them Friends; feels more in line with most social media websites. The Model is a little different here. Instead of a simple has-many, it needs :following, :following*relationships, :followers*, :follower_relationships, where the following/followers go through the relationships. It's more boilerplate, but.. It just works. We display the follow button on the User/Show page, working similarly to Likes

### Guard

Next thing I added is Guard. Apparently this was the point where Testing needed to happen. I wrote tests for User, Post, Like, Follow and Comment, running them automatically with Guard. I'm still not big on TDD. When you're solo-building it doesn't actually do much to help. I don't think I've ever had a test fail unexpectedly after finishing a part of the architecture. Still, I suppose it shows that I can write some tests if I have to.

### Active Storage

I added Active Storage to store the data for now. Not on the server, just a way to not rely only on seeds.

#### User Editing

Rather than filling in all the User's data on registration, the User can register with only an Username, Email and Password. Then, they can go to the Edit page to do the rest. It's more convenient like that, I'd say. This is where Devise gets a little weird again, beacuse you have to work with registration/edit.html.erb instead of user/edit.

### Partials

I realized I really needed to make some partials. I made partials for User, Post, Create Post, Like Button, Follow Button, Create Comment. Perhaps should've done that to begin with, but I did realize it before duplicating code, so that's quite alright by me.

### Post Images

I thought this might be more difficult, since it was in the 'Extra Credit' section, but it's peanuts; just add has*one_attached :image, as a .permit. Strictly speaking, it's not a Post *OR\* an Image, but... Why would you really need to have it like that if you can just leave one or the other blank?

### Mailer

The Mailer was a difficult one. The problem is that there's no free email providers. Maybe I'm cheap, but I couldn't really be bothered with a subscription in order to keep Odinbook running. I eventually went with Sendgrid, but that runs out after a month, so I didn't use the Password Confirmation pattern on it. It only sent a welcome_email that thanks the user for signing up. It was a pain to get it working, too. I probably need more practice on this.

### Render

With that, the TOP requirements are done and it's time to push it to Render. Honestly, this was way too much of a struggle. I can't tell exactly why it was difficult to get it working, but it was. That's what happens when you overlook some basic stuff. Then, 'all of a sudden' it just works again. But it still takes an afternoon to figure it out because every time you try to deploy it takes a couple minutes before you even see if something happens. That wasn't very fun.

### Cloudinary

Adding Cloudinary to actually store data. Just add it to the Gemfile and done.

### Feed Logic & Pagy

I thought it'd be cute to have some social media mimicking relevancy score. So, the Posts display checks for recency, and counts likes and comments in order to decide how 'hot' a Post is. Hottest posts go to the top, unless you're sorting by how Recent/Old something is. If there were ever 1000 posts on Odinbook, that'd 'organize' them a little. That being said, 1000 posts wouldn't fit on the page, so I added the Pagy gem. It limits the amount of displays in Posts/Index and Users/index, with paging buttons.

The Odin Project says to only show Posts from people you're following... That's kind of stupid because new users will only ever see a blank page. Instead, the system heavily favors followed persons, but displays other's posts as well.

### Turbo

I've also added Turbo. With Render + Neon, the site runs painfully slow. With Turbo, it handles Liking Posts, and uses an infinite scroll method, rather than 'actual' paging.

### Population & Sidebars

The project seeds some fake accounts. They're based on The Odin Project and my D&D Campaign. I've also added a sidebar for 'Advertisements'. Just for fun. Can somebody please return Garritt's Goat?

The other Sidebar is where Facebook would put its navigation stuff, but that doesn't apply here, so there's a welcoming note, instead.

### To Do: Moar Stuff?

Obviously the site's pretty bare-bones compared to Facebook, and the CSS is a bit shabby. Adding the new sidebars has put a bit too much of that blue everywhere. Still, I think that what's there is in a pretty good spot now. Let me know if there's any bugs or if I've missed anything!

## Full TOP Project Requirements:

Use PostgreSQL for your database from the beginning (not SQLite3), that way your deployment will go much more smoothly.

Users must sign in to see anything except the sign in page.

User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast on Devise (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.

Users can send follow requests to other users.

Users can create posts (begin with text only).

Users can like posts.

Users can comment on posts.

Posts should always display the post content, author, comments, and likes.

There should be an index page for posts, which shows all the recent posts from the current user and users they are following.

Users can create a profile with a profile picture. You may be able to get the profile picture when users sign in using
OmniAuth. If this isn’t the case you can use Gravatar to generate the photo.

A user’s profile page should contain their profile information, profile photo, and posts.

There should be an index page for users, which shows all users and buttons for sending follow requests to users the user is not already following or have a pending request.

Set up a mailer to send a welcome email when a new user signs up. Use the Letter Opener gem to test it in development mode.

Deploy your App to a hosting provider.

Set up an email provider and start sending real emails.

### Extra credit

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
