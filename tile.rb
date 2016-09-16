class Tile

attr_accessor :flag, :bomb

attr_reader :value, :revealed

  def initialize(bomb=false,flag=false,value=0,revealed=false)
    @bomb = bomb
    @flag = flag
    @value = value
    @revealed = revealed
  end

  def reveal
    @revealed = true
    @value
  end



end
