require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = create_deck
  end

  def create_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::SIGNS.each { |sign| deck << Card.new(sign, suit) }
    end
    deck.shuffle
  end
end
