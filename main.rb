require_relative 'game'

class Main
  POINT = 21
  MIN_BANK_VALUE = 10
  FINAL_SCORE = 17

  attr_accessor :game

  def start
    puts 'Game "Black Jack"'
    create_game
    main_menu
  end

  def main_menu
    loop do
      puts '
      What do you want to do?
      1 - Give card
      2 - See cards
      3 - See bank
      4 - Skip and finish
      0 - EXIT'

      user_choice = gets.chomp
      case user_choice
      when '1' then give_card
      when '2' then see_cards
      when '3' then see_bank
      when '4' then skip_and_finish
      when '0' then break
      else puts 'Sorry, try again!'
      end
    end
  end

  def create_game
    attempt = 3

    begin
      puts 'What is your name?'
      user_name = gets.chomp

      @game = Game.new
      @game.add_player(user_name)

      make_bet
    rescue StandardError => e
      attempt -= 1
      puts e.message
      puts "Attempts left - #{attempt}"
      retry if attempt.positive?
    end
  end

  def give_card
    user_have_score = @game.user.hands_score <= POINT
    user_have_min_money = @game.user.money >= MIN_BANK_VALUE
    user_have_lower_than_3_card = @game.user.number_hands < 3

    if user_have_score && user_have_min_money && user_have_lower_than_3_card
      @game.give_card_to(@game.user)
      @game.give_card_to(@game.dealer)
    else
      puts 'Recount cards!'
    end
  end

  def make_bet
    @game.make_bet(@game.user)
    @game.make_bet(@game.dealer)
  end

  def see_cards
    hands = @game.current_hands(@game.user)

    print_value = lambda { |name, value|
      format('%<name>-15s %<value>s', name: name, value: value).gsub(' ', '.')
    }

    total_score = 0
    hands.each do |hand|
      total_score += hand.value
      puts print_value.call(hand.sign, hand.value)
    end

    puts print_value.call('Total', total_score)
  end

  def see_bank
    @game.score_sheet
  end

  def skip_and_finish
    @game.give_card_to(@game.dealer) while @game.dealer.hands_score <= FINAL_SCORE

    @game.scoring_game
    restart
  end

  def restart
    puts '
    Try again?
    1 - YES
    2 - NO and EXIT'

    user_choice = gets.chomp

    case user_choice
    when '1' then main_menu
    when '2' then exit(true)
    else puts 'Sorry, try again!'
    end
  end
end

main = Main.new
main.start
