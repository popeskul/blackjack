class Card
  SIGNS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  VALUES = { 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }
  SUITS = %w[+ < ^ <>]
  SIGN_FORMAT = /^([2-9]|10|[JQKA])([+<^]|<>)$/

  attr_reader :value, :sign

  def initialize(sign, suit)
    @sign = sign.to_s + suit
    @value = VALUES[sign] || sign
    validate!
  end

  def validate!
    raise 'Wrong format for card' if sign !~ SIGN_FORMAT
  end
end
