require_relative 'bank'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'

class Game
  BET = 10

  attr_accessor :user, :dealer, :attempt

  def create_game(name)
    @attempt = 0
    @user = User.new(name)
    @dealer = Dealer.new('Dealer')
    @bank = Bank.new
    create_deck
  end

  def start; end

  def make_bet(player)
    if player.money < 10
      puts "Error, your score is #{player.money}. Refill your bank to at least 10 points."
    else
      player.money -= 10
      @bank.money += 10
    end
  end

  def create_deck
    @deck = Deck.new
    @deck.create_deck
  end

  def give_card_to(player)
    attempt
    @deck.rand_card
    @deck.remove_card

    player.hands.hands << @deck.get_deleted_card
    player.hands_score += @deck.get_deleted_card.value
    player.number_hands += 1
  end

  def scoring_game
    user = @user.hands_score
    dealer = @dealer.hands_score
    numbers = [user, dealer]
    point = 21
    close_number = numbers.sort_by{ |i| (i-point).abs }[0]

    @bank.money -= 20

    case close_number <=> user
    when 1
      @dealer.money += 20
      puts "#{@dealer.name} won with #{@dealer.hands_score} score."
    when 0
      if @user.hands_score > 21
        @dealer.money += 20
        puts "#{@dealer.name} won with #{@dealer.hands_score} score."
      else
        @user.money += 20
        puts "#{@user.name} won with #{@user.hands_score} score."
      end
    else
      if @user.hands_score > 21
        @dealer.money += 20
        puts "#{@dealer.name} won with #{@dealer.hands_score} score."
      else
        @dealer.money += 10
        @user.money += 10
        puts "#{@dealer.name} and #{@user.name} divide the bank."
      end
    end

    clear_stats
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

  def scoresheet
    puts 'Money: '
    puts ('%-15s %s' % [@user.name, @user.money]).gsub(' ', '.')
    puts ('%-15s %s' % [@dealer.name, @dealer.money]).gsub(' ', '.')
    puts ('%-15s %s' % ['Bank', @bank.money]).gsub(' ', '.')
  end

  def attempt
    @attempt += 1
  end

  def current_hands(player)
    player.get_hands
  end

  def bank
    @bank.money
  end
end
