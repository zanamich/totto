class WelcomeController < ApplicationController

  require 'csv'

  def index

    render 'welcome/index'

    # CSV.open("../../../Desktop/totto-16.csv", "wb") do |csv|
    #   csv << ["round #", "1", "x", "2"]
    #   @result = {}
    #   response = HTTParty.get('http://ibet.co.il/Toto16ResultsArchive.php')
    #   document = Nokogiri::HTML(response)
    #
    #   rounds_numbers = []
    #   document.css('select#roundNum option').each do |round|
    #     round_number = round.attribute('value').value.to_i
    #     rounds_numbers << round_number if round_number != 0
    #   end
    #
    #   total_rounds = rounds_numbers.count
    #   counter = 1
    #   rounds_numbers.each do |round_number|
    #     puts "round number #{round_number}, total #{counter}/#{total_rounds}"
    #     @result[round_number] = {}
    #     response = HTTParty.get("http://ibet.co.il/Toto16ResultsArchive.php?roundNum=#{round_number}")
    #     document = Nokogiri::HTML(response)
    #
    #     document.css('tr td:first-child').each do |game|
    #       game_result = game.text
    #       @result[round_number][game_result] = (@result[round_number][game_result] || 0) + 1
    #     end
    #     csv << [round_number, @result[round_number]['1'], @result[round_number]['x'] || @result[round_number]['X'] || 0, @result[round_number]['2']]
    #     counter += 1
    #   end
    # end
  end
end
