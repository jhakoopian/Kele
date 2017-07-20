require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @endpoint = 'https://www.bloc.io/api/v1'

    response =  Kele.post(
      "#{@endpoint}/sessions",
      body: { email: email, password: password }
    )

    if response && response["auth_token"]
      # great!
      @auth_token = response["auth_token"]
      puts "#{email} was successfully logged in"
    else
      # invalid login
      puts "Login invalid"
    end
  end

  def get_me
    url = "#{@endpoint}/users/me"

    response = Kele.get(url, headers: { "authorization" => @auth_token })
  end
end
