require_relative 'card_deck'
require_relative 'dealer'
require_relative 'player'
class Main

  ACTIONS = [
    {id: 1, title: 'Пропустить ход', action: :skip},
    {id: 2, title: 'Добавить карту', action: :take_card},
    {id: 3, title: 'Вскрыть карты', action: :show}
  ]

  attr_reader :user, :dealer, :bank, :card_deck

  def initialize
    @user = Player.new
    @dealer = Dealer.new
    @bank = 0
    @card_deck = []
  end

  def start
    get_user_name!
    start_game
  end

  def get_user_name!
    puts 'Как тебя зовут?'
    user.name = gets.chomp.capitalize
  end

  def start_game
    until dealer.chips == 0 || user.chips ==0
      beginning_game
      until user.hand.length == 3 && dealer.hand.length == 3 
        break if user_action.include?('show')
        dealer_action
      end
      break if proccess_result
    end
  end

  def beginning_game
    user.return_cards
    dealer.return_cards
    @bank = 0
    @card_deck = CardDeck.new
    2.times do
      user.take_card(card_deck)
      dealer.take_card(card_deck)
    end
    user.place_bet(bank)
    dealer.place_bet(bank)
    intermediate_status
  end
  
  def intermediate_status
    puts "Ваши карты:"
    user.hand.each {|card| print "#{card[:kind].capitalize} "}
    puts "(Сумма очков: #{user.hand_value})"
    puts "Карты диллера:"
    dealer.hand.length.times {print "*  "}
  end

  def user_action
    return user.show if user.hand.length > 2
    puts "\nВыберите действие:"
    ACTIONS.each {|action| puts "#{action[:id]} - #{action[:title]}"}
    user_choise = gets.chomp.to_i
    ACTIONS.map {|action| send(action[:action]) if user_choise == action[:id]}.compact
  end

  def skip
  end

  def show
    user.show
  end

  def take_card
    user.take_card(card_deck)
  end

  def dealer_action
    if dealer.hand_value < 17 && dealer.hand.length < 3
      dealer.take_card(card_deck)
      puts 'Диллер добавил карту'
    else
      dealer.skip
      puts 'Диллер пропустил ход'
    end
    intermediate_status
  end

  def proccess_result
    puts "Ваши карты:"
    user.hand.each {|card| print "#{card[:kind].capitalize} "}
    puts "(Сумма очков: #{user.hand_value})"

    puts "Карты диллера:"
    dealer.hand.each {|card| print "#{card[:kind].capitalize} "}
    puts "(Сумма очков: #{dealer.hand_value})"

    if user.hand_value < 22 && (user.hand_value > dealer.hand_value || dealer.hand_value > 21)
      user_win
    elsif dealer.hand_value < 22 && (user.hand_value < dealer.hand_value || user.hand_value > 21)
      user_lose
    else
      both
    end
    puts "Повторим?\n1 - Да\n2 - Выйти из игры"
    gets.chomp.to_i == 2 ? true : false
  end

  def user_win
    puts 'Вы победили!'
    user.chips += bank
  end

  def user_lose
    puts 'Вы проиграли :('
    dealer.chips += bank
  end

  def both
    puts 'Ничья!'
    user.chips += bank / 2
    dealer.chips += bank / 2
  end
end