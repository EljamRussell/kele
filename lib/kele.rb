require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  attr_reader :me

  def initialize(email, password)
    response = self.class.post(api_url("/sessions"), body: { "email": email, "password": password })
    # puts response.inspect
    raise "Invalid Email or Password" if response.code == 404 || response.code == 401
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url('/users/me'), headers: { "authorization" => @auth_token })
    @me = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("/mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page)
    if page == nil
      response = self.class.get(api_url("/message_threads"), headers: { "authorization" => @auth_token })
    else
      response = self.class.get(api_url("/message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
    end
    @get_messages = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, stripped_text, subject=nil, token=nil)
    body = {
      "sender": sender,
      "recipient_id": recipient_id,
      "stripped-text": stripped_text}
    body.merge!({"token": token}) unless token.nil?
    body.merge!({"subject": subject}) unless subject.nil?
    puts body.inspect
    response = self.class.post(api_url("/messages"),
      body: body,
      headers: {"authorization" => @auth_token}
    )
    puts response.inspect
  end

    def create_submission(checkpoint_id, enrollment_id, comment, assignment_branch=nil, assignment_commit_link=nil)
      body = {
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": enrollment_id
      }
      body.merge!({"assignment_branch": assignment_branch}) unless assignment_branch.nil?
      body.merge!({"assignment_commit_link": assignment_commit_link}) unless assignment_commit_link.nil?
      response = self.class.post(api_url("/checkpoint_submissions"),
        body: body,
        headers: {"authorization" => @auth_token}
      )
      puts response.inspect
    end

        def api_url(endpoint)
          "https://www.bloc.io/api/v1#{endpoint}"
        end
      end
