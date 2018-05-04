# 7 x 6 connect four board
class Board
  attr_reader :slots, :COLUMNS, :ROWS

  def initialize
    @COLUMNS = 7
    @ROWS = 6
    @slots = Array.new(@COLUMNS * @ROWS)
  end

  def drop_in(color, column)
    row = 1
    row += 1 until check_slot(column, row).nil? || row > @ROWS
    @slots[(row - 1) * 7 + column - 1] = color
  end

  # returns a value from slot array by coordinates 
  def check_slot(column, row)
    @slots[(row - 1) * @COLUMNS + column - 1]
  end

  # Used to show border of the board
  def print_board
    row_index = 0
    @ROWS.times do
      col_index = 0
      @COLUMNS.times do
        slot = @slots[row_index * @COLUMNS + col_index]
        slot = '*' if slot.nil?
        print slot
        col_index += 1
      end
      print "\n"
      row_index += 1
    end
  end
end

subject = Board.new
2.times { subject.drop_in(:R, 1) }
subject.print_board
