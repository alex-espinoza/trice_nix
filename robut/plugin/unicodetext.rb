require 'open-uri'
require 'nokogiri'

class Robut::Plugin::UnicodeText
  include Robut::Plugin

  desc "unicode <text> - trice nix responds with a unicode version of text"

  match "^(unicode) (.+)$", sent_to_me: true do |matchers, message|
    text = URI.encode(message)
    url = "http://www.panix.com/~eli/unicode/convert.cgi?text=#{text}"
    page = Nokogiri::HTML(open(url))
    unicode_string = page.css('tr')[1].css('td')[1].text.delete!("\n")

    reply(unicode_string)
  end
end
