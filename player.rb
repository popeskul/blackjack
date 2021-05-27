require_relative 'deck'
require_relative 'bank'
require_relative 'hand'

class Player
  attr_accessor :score, :name, :hands

  def initialize(name)
    @name = name
    @score = 100
    @hands = Hand.new
  end

  def create_deck
    @deck = Deck.new.create_deck
  end

  def get_hands
    puts ('%-15s %s' % ['Card', 'Score']).gsub(' ', '.')

    total_score = 0
    @hands.hands.each do |hand|
      total_score += hand.value
      puts ('%-15s %s' % [hand.sign, hand.value]).gsub(' ', '.')
    end

    puts ('%-16s' % ['']).gsub(' ', '-')
    puts ('%-15s %s' % ['Total', total_score]).gsub(' ', '.')
  end
end
