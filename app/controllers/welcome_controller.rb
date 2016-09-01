class WelcomeController < ApplicationController
  def index
    document = Nokogiri::HTML('http://www.google.com')
    @result = 'micha'
  end
end
