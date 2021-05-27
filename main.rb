require_relative 'game'

class Main
  attr_accessor :game

  def start
    puts 'Game "Black Jack"'
    create_game
    main_menu
  end

  def main_menu
    loop do
      puts 'What do you want to do?'
      puts '%-15s 1' % 'Give card'
      puts '%-15s 2' % 'See cards'
      puts '%-15s 3' % 'See bank'
      puts '%-15s 4' % 'Skip and finish'
      puts '%-15s 0' % 'EXIT'

      usder_choice = gets.chomp
      case usder_choice
      when '1' then give_card
      when '2' then hands
      when '3' then bank
      when '4' then winner
      when '0' then break
      else puts 'Sorry, try again!'
      end
    end
  end

  def give_card
    if @game.user.hands_score <= 21 && @game.user.money >= 10 && @game.user.number_hands < 3
      @game.give_card_to(@game.user)
      @game.give_card_to(@game.dealer)
    else
      puts "Recount cards!"
    end
  end

  def create_game
    begin
      puts 'What is your name?'
      user_name = gets.chomp
      raise 'Sorry, try again...' if ['',' ',nil].include?(user_name)

      @game = Game.new
      @game.create_game(user_name)
      make_bet
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def make_bet
    @game.make_bet(@game.user)
    @game.make_bet(@game.dealer)
  end

  def hands
    @game.current_hands(@game.user)
  end

  def bank
    @game.scoresheet
  end

  def score
    @game.scoresheet
  end

  def winner
    while @game.dealer.hands_score <= 17
      @game.give_card_to(@game.dealer)
    end

    @game.scoring_game

    restart
  end

  def restart
    begin
      puts 'Try again'
      puts '%-15s 1' % 'YES'
      puts '%-15s 2' % 'NO and EXIT'

      usder_choice = gets.chomp
      raise 'Sorry, try again...' unless ['1','2'].include?(usder_choice)

      case usder_choice
      when '1' then main_menu
      when '2' then exit(true)
      else puts 'Sorry, try again!'
      end
    rescue StandardError => e
      puts e.message
      retry
    end
  end
end
