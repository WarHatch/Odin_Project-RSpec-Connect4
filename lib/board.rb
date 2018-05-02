# 7 x 6 connect four board
class Board
  attr_reader :slots

  def initialize
    @COLUMNS = 6
    @ROWS = 7
    @slots = Array.new(@COLUMNS * @ROWS)
  end

  def drop_in(color, column)
    row = 0
    row += 1 until @slots[row * 7 + column - 1].nil? || row > @ROWS
    @slots[row * 7 + column - 1] = color
  end
end
