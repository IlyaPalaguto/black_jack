class Player < Dealer
  attr_accessor :name

  def initialize
    super
    @name = nil
  end

  def show
    'show'
  end

end