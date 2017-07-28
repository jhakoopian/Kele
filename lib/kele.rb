require 'httparty'
require 'roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    @endpoint = 'https://www.bloc.io/api/v1'

    response = Kele.post(
      "#{@endpoint}/sessions",
      body: { email: email, password: password }
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} was successfully logged in"
    else
      puts "Login invalid"
    end
  end

  def get_me
    url = "#{@endpoint}/users/me"

    response = Kele.get(url, headers: { "authorization" => @auth_token })
  end

  def get_mentor_availability
    url = "#{@endpoint}/mentors/539470/student_availability"

    response = Kele.get(url, headers: { "authorization" => @auth_token })
  end

  def get_messages(*page)
    url = "#{@endpoint}/message_threads"

    if page == []
      response = Kele.get(url, {headers: { "authorization" => @auth_token }})
    else
      response = Kele.get("#{url}?page=#{page[0]}", {headers: { "authorization" => @auth_token }})
    end

    JSON.parse(response.body)
  end

  def create_message
    response = Kele.post(
      "#{@endpoint}/messages",
      headers: {
        authorization: @auth_token
      },
      body: {
        sender: "joseph.hakoopian@gmail.com",
        recipient_id: 539470,
        subject: "test message",
        "stripped-text" => "trying to get this to work"
      }
    )
    if response.success?
      puts "Nicely done"
    else
      puts "Whoops - response: #{response.inspect}"
    end
  end
end
