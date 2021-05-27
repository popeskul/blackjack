require_relative 'card'

class Deck
  attr_accessor :deleted_card

  def create_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::SIGNS.each { |sign| deck << Card.new(sign, suit) }
    end
    @deck = deck.shuffle
  end

  def rand_card
    @deleted_card = @deck[rand(@deck.length - 1)]
  end

  def remove_card
    @deck.delete(@deleted_card)
  end
end
