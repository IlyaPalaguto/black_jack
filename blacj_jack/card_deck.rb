class CardDeck
  attr_reader :cards

  def initialize
    @cards = [
      {kind: :deuce♥, value: [2]},
      {kind: :deuce♦, value: [2]},
      {kind: :deuce♠, value: [2]},
      {kind: :deuce♣, value: [2]},
      {kind: :three♦, value: [3]},
      {kind: :three♥, value: [3]},
      {kind: :three♠, value: [3]},
      {kind: :three♣, value: [3]},
      {kind: :four♦, value: [4]},
      {kind: :four♥, value: [4]},
      {kind: :four♠, value: [4]},
      {kind: :four♣, value: [4]},
      {kind: :five♦, value: [5]},
      {kind: :five♥, value: [5]},
      {kind: :five♠, value: [5]},
      {kind: :five♣, value: [5]},
      {kind: :six♦, value: [6]},
      {kind: :six♥, value: [6]},
      {kind: :six♠, value: [6]},
      {kind: :six♣, value: [6]},
      {kind: :seven♦, value: [7]},
      {kind: :seven♥, value: [7]},
      {kind: :seven♠, value: [7]},
      {kind: :seven♣, value: [7]},
      {kind: :eight♦, value: [8]},
      {kind: :eight♥, value: [8]},
      {kind: :eight♠, value: [8]},
      {kind: :eight♣, value: [8]},
      {kind: :nine♦, value: [9]},
      {kind: :nine♥, value: [9]},
      {kind: :nine♠, value: [9]},
      {kind: :nine♣, value: [9]},
      {kind: :ten♦, value: [10]},
      {kind: :ten♥, value: [10]},
      {kind: :ten♠, value: [10]},
      {kind: :ten♣, value: [10]},
      {kind: :jack♦, value: [10]},
      {kind: :jack♥, value: [10]},
      {kind: :jack♠, value: [10]},
      {kind: :jack♣, value: [10]},
      {kind: :queen♦, value: [10]},
      {kind: :queen♥, value: [10]},
      {kind: :queen♠, value: [10]},
      {kind: :queen♣, value: [10]},
      {kind: :king♦, value: [10]},
      {kind: :king♥, value: [10]},
      {kind: :king♠, value: [10]},
      {kind: :king♣, value: [10]},
      {kind: :ace♦, value: [11, 1]},
      {kind: :ace♥, value: [11, 1]},
      {kind: :ace♠, value: [11, 1]},
      {kind: :ace♣, value: [11, 1]}
    ]
  end

  def random_card
    cards.delete(cards.sample)
  end

  def length
    cards.length
  end

end