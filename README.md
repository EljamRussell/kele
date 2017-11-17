# kele API CLIENT
A Ruby Gem for Bloc students and mentors using API

# Project Objectives

Kele retrieves and stores an authentication token when passed valid credentials
Students can retrieve their info as a JSON blog
Students can retrieve a list of their mentor's availability
Students can retrieve roadmaps and checkpoints
Students can retrieve a list of their messages, respond to an existing message, and create a new message thread
Students can submit checkpoint assignments

# Built With

Ruby 2.3.3
HTTParty Gem
JSON Gem

# Setup

Add this line to your application's Gemfile:

`gem 'kele_kasey'`

And then execute:

`$ bundle install`

Or install it yourself as:

`$ gem install ./kele_kasey-0.0.1.gem`

# Getting started

Require kele Gem on irb:

`require 'kele'`

Create a new variable using your Bloc login email and password. Kele will securely post your credentials to Bloc's API for an authentication token!

`k = Kele.new('student@bloc.com', 'Password')`

# Retrieving user info

On irb, using the `get_me` method users can retrieve user info as JSON and convert it into a Ruby hash.

`k.get_me`

# Getting Mentor Availability

With a `mentor_id`, can retrieve mentor's available time with `get_mentor_availability` and convert it into a ruby array.

`k.get_mentor_availability(mentor_id)`

# Checking Roadmaps and Checkpoints

With `roadmap_id` and `checkpoint_id`, user can retrieve associated Bloc's roadmap and checkpoint information using `get_roadmap(roadmap_id)` and `get_checkpoint(checkpoint_id)`, respectively.

`k.get_roadmap(roadmap_id)`
`k.get_checkpoint(checkpoint_id)`

# Retrieving and sending messages

Kele can retrieve all message in history using `get_messages method`. If given an argument `page`, `get_messages(page)` will return message thread `page` (message thread is pagninated with 10 messages per page); `get_messages` without argument will return all messages.

`k.get_messages`

Kele can create messages using `create_message(sender, recipient_id, stripped_text, subject=nil, token=nil))` whereas subject is message subject and stripped is message's content.  "Token is only necessary when you reply to a message and not when you create a message. If you pass a token, then you don't need a subject because is already a subject for the exiting message."

`k.create_message(sender, recipient, st, 'test subject 2')`

# Submitting Checkpoints

Kele can create new Bloc checkpoint submission using `create_submission(checkpoint_id, enrollment_id, comment, assignment_branch=nil, assignment_commit_link=nil)`

`k.create_submission(cp, enrol, 'testing 1')`

# Update Checkpoints
kele can update Bloc chekcpoint submission using `update_submission(submission_id, checkpoint_id, enrollment_id, comment, assignment_branch=nil, assignment_commit_link=nil)`

`k.update_submission(sub, cp, enrol,  'UPDATE SUBMISSION')`

# API Reference

Bloc's base API URL: https://www.bloc.io/api/v1 API documentation: http://docs.blocapi.apiary.io/
