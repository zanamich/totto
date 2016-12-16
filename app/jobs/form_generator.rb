class FormGenerator

  @queue = :FormGenerator

  def self.perform
    create_history_csv
  end

  private

  def create_history_csv
    CSV.open("../../../Desktop/totto-16.csv", "wb") do |csv|
      csv << ["round #", "1", "x", "2"]
      @result = {}
      response = HTTParty.get('http://ibet.co.il/Toto16ResultsArchive.php')
      document = Nokogiri::HTML(response)

      rounds_numbers = []
      document.css('select#roundNum option').each do |round|
        round_number = round.attribute('value').value.to_i
        rounds_numbers << round_number if round_number != 0
      end

      total_rounds = rounds_numbers.count
      counter = 1
      rounds_numbers.each do |round_number|
        puts "round number #{round_number}, total #{counter}/#{total_rounds}"
        @result[round_number] = {}
        response = HTTParty.get("http://ibet.co.il/Toto16ResultsArchive.php?roundNum=#{round_number}")
        document = Nokogiri::HTML(response)

        document.css('tr td:first-child').each do |game|
          game_result = game.text
          @result[round_number][game_result] = (@result[round_number][game_result] || 0) + 1
        end
        if (@result[round_number]['1'] || 0) + (@result[round_number]['x'] || @result[round_number]['X'] || 0) + (@result[round_number]['2'] || 0) >= 15
          csv << [round_number, @result[round_number]['1'] || 0, @result[round_number]['x'] || @result[round_number]['X'] || 0, @result[round_number]['2'] || 0]
        end
        counter += 1
      end
    end
  end

end