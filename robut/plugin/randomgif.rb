require 'httparty'
require 'json'

class Robut::Plugin::RandomGif
  include Robut::Plugin

  desc "gif me <term> - asks trice nix to do find a random gif from giphy with <term> provided"

  match "^(gif me) (.+)$", sent_to_me: true do |matchers, message|
    text = message.split(" ").join("+")
    url = "http://api.giphy.com/v1/gifs/random?tag=#{text}&rating=pg-13&api_key=dc6zaTOxFJmzC"
    response = HTTParty.get(url)
    body = JSON.parse(response.body)

    if body["data"].empty?
      reply("Sorry, I couldn't find any gifs with the term '#{message}'.")
    else
      reply(body["data"]["image_original_url"])
    end
  end
end
