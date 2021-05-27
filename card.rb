require_relative 'modules/validation'

class Card
  SIGNS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  VALUES = { 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze
  SUITS = %w[+ < ^ <>].freeze
  SIGN_FORMAT = /^([2-9]|10|[JQKA])([+<^]|<>)$/

  attr_accessor :value
  attr_reader :sign

  def initialize(sign, suit)
    @sign = sign.to_s + suit
    @value = VALUES[sign] || sign
  end
end
