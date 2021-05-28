require_relative 'bank'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'

class Game
  BET = 10
  POINT = 21
  MIN_BANK_VALUE = 10

  attr_accessor :user, :dealer, :attempt

  def initialize
    @attempt = 0
    @dealer = Dealer.new
    @bank = Bank.new
    @deck = Deck.new
  end

  def add_player(name)
    @user = User.new(name)
  end

  def make_bet(player)
    if player.money > MIN_BANK_VALUE
      player.money -= BET
      @bank.money += BET
    else
      puts "Error, your score is #{player.money}. Refill your bank to at least 10 points."
    end
  end

  def give_card_to(player)
    @attempt += 1

    @deck.rand_card
    @deck.remove_card

    player.hands.hands << @deck.deleted_card
    player.hands_score += @deck.deleted_card.value
    player.number_hands += 1
  end

  def scoring_game
    user = @user.hands_score
    dealer = @dealer.hands_score
    numbers = [user, dealer]
    close_number = numbers.min_by { |i| (i - POINT).abs }

    @bank.money -= 20

    count_the_winner(close_number)

    clear_stats
  end

  def count_the_winner(close_number)
    print_the_winner = ->(name, score) { "1 - #{name} won with #{score} score." }

    case close_number <=> user
    when 1
      @dealer.money += 20
      puts print_the_winner.call(@dealer.name, @dealer.hands_score)
    when 0
      if @user.hands_score > POINT
        @dealer.money += 20
        puts print_the_winner.call(@dealer.name, @dealer.hands_score)
      else
        @user.money += 20
        puts print_the_winner.call(@user.name, @user.hands_score)
      end
    else
      if @user.hands_score > POINT
        @dealer.money += 20
        puts print_the_winner.call(@dealer.name, @dealer.hands_score)
      else
        @dealer.money += BET
        @user.money += BET
        puts "#{@dealer.name} and #{@user.name} divide the bank."
      end
    end
  end


  def clear_stats
    @attempt = 0

    @user.hands.hands = []
    @user.hands_score = 0
    @user.number_hands = 0

    @dealer.hands.hands = []
    @dealer.hands_score = 0
    @dealer.number_hands = 0
  end

  def score_sheet
    print_scores = ->(name, money) { format('%-15s %s', name, money).gsub(' ', '.') }

    puts 'Money: '
    puts print_scores.call(@user.name, @user.money)
    puts print_scores.call(@dealer.name, @dealer.money)
    puts print_scores.call('Bank', @bank.money)
  end

  def current_hands(player)
    total_score = 0

    player.hands.hands.each do |hand|
      total_score += hand.value
      puts format('%-15s %s', hand.sign, hand.value).gsub(' ', '.')
    end
  end
end
