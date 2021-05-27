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
      puts '%-15s 1' % 'Cards'
      puts '%-15s 2' % 'See cards'
      puts '%-15s 3' % 'See bank'

      usder_choice = gets.chomp
      case usder_choice
      when '1' then cards_menu
      when '2' then hands
      when '3' then bank
      else puts 'Sorry, try again!'
      end
    end
  end

  def cards_menu
    begin
      puts 'What do you want to do with CARDS?'
      puts '%-15s 1' % 'Give card'
      puts '%-15s 2' % 'Skip and finish'
      puts '%-15s 0' % 'Back'

      usder_choice = gets.chomp
      raise 'Sorry, try again...' unless ['0','1','2','3'].include?(usder_choice)

      case usder_choice
      when '1' then give_card
      when '2' then winner
      when '0' then main_menu
      else puts 'Sorry, try again!'
      end
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def give_card
    @game.give_card_to(@game.user)
    @game.give_card_to(@game.dealer)
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
    while @game.dealer.hands_score < 17
      @game.give_card_to(@game.dealer)
    end

    @game.scoring_game
  end
end
