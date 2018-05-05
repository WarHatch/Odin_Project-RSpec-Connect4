# 7 x 6 connect four board
class Board
  attr_reader :slots, :COLUMNS, :ROWS, :turn_color

  # Yellow player starts the game
  def initialize
    @COLUMNS = 7
    @ROWS = 6
    @slots = Array.new(@COLUMNS * @ROWS)
    @turn_color = :Y
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

  def switch_colors
    @turn_color = @turn_color == :Y ? :R : :Y
  end

  def ask_where_to_drop
    puts "From 1 to #{@COLUMNS} choose a column to drop your slot in"
    chosen_column = gets.chomp.to_i
    chosen_column = ask_where_to_drop until chosen_column.between? 1, @COLUMNS
    chosen_column
  end

  # The player whose turn is up drops a slot
  def make_turn
    drop_in @turn_color, ask_where_to_drop

    switch_colors
  end
end
