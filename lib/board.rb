# 7 x 6 connect four board
class Board
  attr_reader :slots, :COLUMNS, :ROWS, :turn_color

  # Yellow player starts the game
  def initialize
    @COLUMNS = 7
    @ROWS = 6
    @slots = Array.new(@COLUMNS * @ROWS)
    @turn_color = :Y
    @won = nil
  end

  def drop_in(color, column)
    row = 1
    row += 1 until check_slot(column, row).nil? || row > @ROWS
    landed_at = [column, row]
    @slots[(row - 1) * 7 + (column - 1)] = color
    landed_at
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

  # TODO: refactor method to check_in_direction
  def check_orthogonally(x, y)
    won = false
    # up
    index = 1
    while index < 4 && (y + index).between?(1, @ROWS) && !check_slot(x,y + index).nil?
      index += 1
      won = true if index == 4
    end

    # down
    unless won
      index = 1
      while index < 4 && (y - index).between?(1, @ROWS) && !check_slot(x,(y - index)).nil?
        index += 1
        won = true if index == 4
      end
    end

    # left
    unless won
      index = 1
      while index < 4 && (x - index).between?(1, @ROWS) && !check_slot((x - index), y).nil?
        index += 1
        won = true if index == 4
      end
    end

    # down
    unless won
      index = 1
      while index < 4 && (x + index).between?(1, @ROWS) && !check_slot((x + index) ,y).nil?
        index += 1
        won = true if index == 4
      end
    end

    won
  end

  def check_if_won(last_slot)
    won = check_orthogonally(last_slot[0], last_slot[1])
    won
  end

  # The player whose turn is up drops a slot and may win
  def make_turn
    column = ask_where_to_drop
    landed_at = drop_in @turn_color, column
    check_if_won landed_at
    switch_colors
  end
end
