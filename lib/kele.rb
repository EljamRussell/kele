require 'httparty'

class Kele
  include HTTParty

  attr_reader :me

  def initialize(email, password)
    response = self.class.post(api_url("/sessions"), body: { "email": email, "password": password })
    # puts response.inspect
    raise "Invalid Email or Password" if response.code == 404 || response.code == 401
    @auth_token = response["auth_token"]
  end

  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1#{endpoint}"
  end
end
