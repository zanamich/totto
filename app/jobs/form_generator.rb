class FormGenerator

  require 'csv'

  @queue = :FormGenerator
  @result_forms = []

  def self.perform
    @bankers = { 0 => '1',
                 3 => 'X',
                 4 => '1',
                 7 => '2',
                 8 => '2',
                 10 => 'X',
                 13 => '1'
    }
    form_structure = create_history_csv
    create_permutations form_structure, [], 0, %w(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
    puts 'done'
  end

  def self.create_history_csv
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
    #     if (@result[round_number]['1'] || 0) + (@result[round_number]['x'] || @result[round_number]['X'] || 0) + (@result[round_number]['2'] || 0) >= 15
    #       csv << [round_number, @result[round_number]['1'] || 0, @result[round_number]['x'] || @result[round_number]['X'] || 0, @result[round_number]['2'] || 0]
    #     end
    #     counter += 1
    #   end
    # end

    return [4,7,5]

  end

  def self.create_permutations form_structure, bankers, index, form

    return unless validate_instances(form, form_structure)

    form[index] = '1'
    puts 'A: ' + form.inspect
    create_permutations form_structure, bankers, index + 1, form.dup if index < 15

    form[index] = 'X'
    puts 'B: ' +  form.inspect
    create_permutations form_structure, bankers, index + 1, form.dup if index < 15

    form[index] = '2'
    puts 'C: ' +  form.inspect
    create_permutations form_structure, bankers, index + 1, form.dup if index < 15

  end

  def self.validate_instances form, form_structure
    counts = Hash.new 0
    num_of_guesses = 0

    form.each do |guess|
      counts[guess] += 1
      num_of_guesses += 1 if %w(1 X 2).include?(guess)
    end

    if counts['1'] > form_structure[0] || counts['X'] > form_structure[1] || counts['2'] > form_structure[2]
      puts 'FORM STRUCTURE CONFLICT'
      return false
    end

    return false if num_of_guesses > 16

    @bankers.each do |index, value|
      if form[index] != value && form[index] != '0'
        puts 'BANKER CONFLICT'
        return false
      end
    end

    @result_forms << form.dup if num_of_guesses == 16

    true
  end

end