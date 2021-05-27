class Interface
  def user_interface
    puts 'Welcome to "Black Jack"'
    puts 'Select an option:'
    puts 'START - type 1 number '
    puts 'Exit  - type 0 or any LETTER'

    begin
      user_start = gets.chomp.to_i
      raise 'Sorry, try again...' if user_start != 0 && user_start != 1
      case user_start
      when 1 then # start
      when 0 then puts 'Goodbye!'
      else puts 'Sorry, try again!'
      end
    rescue StandardError => e
      puts e.message
      retry
    end
  end
end

game = Interface.new
game.user_interface
