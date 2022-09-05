module Actions
  attr_accessor :hand

  def take_card(card)
    @hand ||= []
    @hand << card
  end

  def hand_value
    values = []
    aux = []
    @hand.each do |card|
      aux += card[:value].one? ? card[:value] : [1]
      values += card[:value]
    end
    values_combination = values.combination(@hand.length).to_a.map!(&:sum)
    values_combination.map! {|value| value if value < 22 && ((value - aux.sum) % 10 == 0 || value == aux.sum)}
    return [21] if values_combination.include?(21)
    return values_combination.compact.uniq
  end
  
end