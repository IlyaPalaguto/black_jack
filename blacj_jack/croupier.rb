class Croupier
  include CardDeck
  include Actions
  attr_reader :card_deck, :bank, :rating, :players_in_game

  def initialize
    @card_deck = nil
    @bank = 0
    @rating = {wins: 0, loses: 0}
    @players_in_game = []
  end

  def clear_bank!
    @bank = 0
  end

  def get_new_deck!
    @card_deck = CardDeck.get
  end
  
  def accept_bet(bet, player)
    @bank += bet * 2
    register_player!(player)
  end
  
  def give_card(one)
    give_card!(one) if one.in_game?
  end
  
  def in_game?
    true
  end
  
  private

  def give_card!(one)
    one.take_card(card_deck.delete(card_deck.sample))
  end
  
  def register_player!(player)
    players_in_game << player
  end
  
end



