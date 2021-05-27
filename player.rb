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
end
