class Dealer
  attr_accessor :chips
  attr_reader :hand

  def initialize
    @chips = 100
    @hand = []
  end

  def place_bet(bank)
    @chips -= 10
    bank += 10
  end

  def take_card(card_deck)
    hand << card_deck.random_card
  end

  def return_cards
    @hand = []
  end

  def skip
  end

  def hand_value
    values = []
    aux = []
    @hand.each do |card|
      aux += card[:value].one? ? card[:value] : [1]
      values += card[:value]
    end
    values_combination = values.combination(@hand.length).to_a.map!(&:sum)
    values_combination.map! {|value| value if (value - aux.sum) % 10 == 0 || value == aux.sum}
    values_combination.uniq!
    values_combination.compact!
    if values_combination.one?
      return values_combination[0]
    else
      return values_combination.min if values_combination.any?{|value| value > 21}
      values_combination.max
    end
  end
  
end



