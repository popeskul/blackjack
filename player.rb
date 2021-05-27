require_relative 'deck'
require_relative 'bank'
require_relative 'hand'

class Player
  attr_accessor :money, :name, :hands, :hands_score, :number_hands

  def initialize(name)
    @name = name
    @money = 100
    @hands = Hand.new
    @number_hands = 0
    @hands_score = 0
  end

  def create_deck
    @deck = Deck.new.create_deck
  end

  def make_bet
    if @money < 10
      puts "Error, your score is #{@money}. Refill your bank to at least 10 points."
    else
      @money -= 10
    end
  end

  def get_hands
    if @hands.hands.length > 0
      puts "#{name}'s cards:"
      puts ('%-15s %s' % ['Card', 'Score']).gsub(' ', '.')

      total_score = 0
      @hands.hands.each do |hand|
        total_score += hand.value
        puts ('%-15s %s' % [hand.sign, hand.value]).gsub(' ', '.')
      end

      puts ('%-16s' % ['']).gsub(' ', '-')
      puts ('%-15s %s' % ['Total', total_score]).gsub(' ', '.')
    else
      puts "#{@name} dont have cards!"
    end
  end
end
