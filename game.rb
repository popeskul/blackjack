require_relative 'bank'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'hand'

class Game
  BET = 10

  attr_accessor :user, :dealer

  def create_game
    @user = User.new('Pasha')
    @dealer = Dealer.new('Dealer')
    @bank = Bank.new
    create_deck
  end

  def start; end

  def make_bet(player)
    if player.score < 10
      puts "Error, your score is #{player.score}. Refill your bank to at least 10 points."
    else
      player.score -= 10
      @bank.score += 10
    end
  end

  def create_deck
    @deck = Deck.new
    @deck.create_deck
  end

  def give_card_to(player)
    @deck.rand_card
    @deck.remove_card
    player.hands.hands << @deck.get_deleted_card
    player.hands.hands.each {|hand| puts "Our card is #{hand.sign} with score #{hand.value}"}
  end

  def scoresheet
    puts 'Game points'
    puts ('%-15s %s' % [@user.name, @user.score]).gsub(' ', '.')
    puts ('%-15s %s' % [@dealer.name, @dealer.score]).gsub(' ', '.')
    puts ('%-15s %s' % ['Bank', @bank.score]).gsub(' ', '.')
  end

  def current_hands(player)
    player.get_hands
  end

  def bank
    @bank.score
  end
end
