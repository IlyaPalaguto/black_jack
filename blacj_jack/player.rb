class Player
  include Actions
  attr_accessor :chips
  attr_reader :name, :active_croupier, :status

  def initialize(name)
    @name = name
    @chips = 1000
    @active_croupier = nil
  end

  def in_game?
    active_croupier.players_in_game.include?(self)
  end
  
  def choise_croupier(croupier)
    @active_croupier = croupier
  end

  def place_bet(bet_size)
    raise 'Нет выбранного крупье' unless active_croupier
    raise 'Недостаточно денег' if bet_size > @chips

    @chips -= bet_size
    @active_croupier.accept_bet(bet_size, self)
  end


end