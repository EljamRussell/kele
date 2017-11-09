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

  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1#{endpoint}"
  end
end
