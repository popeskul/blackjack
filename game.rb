require_relative 'user'
require_relative 'dealer'

class Game
  def initialize
    @all_user   = []
  end

  def create_user
    @all_user += [User.new('Pasha'), Dealer.new]
  end

  def score
    @all_user.each do |player|
      puts "#{player.class} - #{player.score}"
    end
  end

  def add_cards

  end

  def skip_cards

  end

  def open_cards

  end

  def show_result

  end
end
