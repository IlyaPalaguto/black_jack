require_relative 'actions'
require_relative 'card_deck'
require_relative 'croupier'
require_relative 'player'

class Main
  attr_reader :user, :active_croupier

  MENU = [
    {id: 1, title: 'Создать крупье', action: :create_croupier},
    {id: 2, title: 'Выбрать крупье и сесть за стол', action: :select_table},
    {id: 3, title: 'Начать игру', action: :play_game},
    {id: 0, title: 'Выйти из игры', action: :exit_game}
  ]

  def initialize
    @user = nil
    @croupiers = []
    @active_croupier = nil
  end

  def start
    get_user_name!
    show_menu
  end

  def get_user_name!
    puts 'Как тебя зовут?'
    @user = Player.new(gets.chomp.downcase)
  end
  
  def show_menu
    loop do 
      MENU.each {|i| puts "#{i[:id]} - #{i[:title]}"}
      user_choise = gets.chomp.to_i
      MENU.each {|i| user_choise = send(i[:action]) if i[:id] == user_choise}
      break if user_choise == 'exit'
    rescue RuntimeError => e     
      puts e.message
    end
  end
  
  def create_croupier
    puts "Крупье успешно создан"
    @croupiers << Croupier.new
  end

  def select_table
    raise 'Сначало нужно создать крупье' if @croupiers.empty?

    @croupiers.each_with_index do |croupier, index|
      puts "Стол №#{index + 1} (Крупье #{croupier.rating[:wins]}/#{croupier.rating[:loses]})"
    end
    puts "#{@user.name.capitalize}, какой стол выбираешь?"
    @active_croupier = (@croupiers[gets.chomp.to_i - 1])
    @user.choise_croupier(@active_croupier)
  end

  def play_game
    raise 'Для начала игры нужно выбрать стол' if @user.active_croupier.nil?

    beginning_game
    intermediate_status
    loop do
      break if action_user || @user.hand_value.empty?
      intermediate_status
    end
    action_croupier if !@user.hand_value.empty?
    proccess_result
    end_game
  end

  def beginning_game
    puts "#{@user.name}, сделайте вашу ставку (Баланс фишек: #{@user.chips})"

    @user.place_bet(gets.chomp.to_i)
    @active_croupier.get_new_deck!
    2.times {@active_croupier.give_card(@user)}
    @active_croupier.give_card(@active_croupier)
  end

  def intermediate_status
    puts "Ваши карты:"
    @user.hand.each {|card| print "#{card[:kind].capitalize}  "}
    puts "(Всего очков: #{@user.hand_value[0]})"
    puts "Карты крупье:"
    if @active_croupier.hand.length > 1
      @active_croupier.hand.each {|card| print "#{card[:kind].capitalize} "}
      puts "(Всего очков: #{@active_croupier.hand_value})"
    else
      print "#{@active_croupier.hand[0][:kind].capitalize}  *  "
      puts "(Всего очков: #{@active_croupier.hand_value})"
    end
  end

  def action_user
    puts "1 - Взять карту\n2 - Остановиться"
    user_choise = gets.chomp.to_i
    if user_choise == 1
      @active_croupier.give_card(@user)
      puts "Ваша карта - #{@user.hand.last[:kind]}"
    end
    user_choise == 2 ? true : false
  end
  
  def action_croupier
    while @active_croupier.hand_value.max < @user.hand_value.max
      @active_croupier.give_card(@active_croupier)
      puts "Крупье вытащил #{active_croupier.hand.last[:kind]}" if @active_croupier.hand.length > 2
      sleep(2)
      intermediate_status
      sleep(1)
      return if @active_croupier.hand_value.max.nil?
    end
  end

  def proccess_result
    return user_lose if @user.hand_value.max.nil?
    return user_win if @active_croupier.hand_value.max.nil?
    if @user.hand_value.max > @active_croupier.hand_value.max
      user_win
    elsif @user.hand_value.max < @active_croupier.hand_value.max
      user_lose
    else
      both
    end
  end

  def user_win
    puts 'Вы победили!'
    @user.chips += @active_croupier.bank
    @active_croupier.rating[:loses] += 1
  end

  def user_lose
    puts "Вы проиграли :("
    active_croupier.rating[:wins] += 1
  end

  def both
    puts 'Ничья!'
    @user.chips += @active_croupier.bank / 2
  end
  
  def end_game
    @active_croupier.clear_bank!
    @user.hand = []
    @active_croupier.hand = []
  end
  
  def exit_game
    'exit'
  end

end