require 'board'

describe Board do
  describe '.new' do
    it 'creates a new board with a 7*6 empty array/slots in it' do
      expect(Board.new.slots.size).to eql 7 * 6
    end
  end

  subject do
    Board.new
  end

  describe '#check_slot' do
    context 'checking first column' do
      it 'finds nothing and returns a nil' do
        expect(subject.check_slot(1, 1)).to eql nil
      end

      context 'after a red slot has been dropped 2 times in the first column' do
        before do
          2.times { subject.drop_in(:R, 1) }
        end
        it 'finds a red on the first row' do
          expect(subject.check_slot(1, 2)).to eql :R
        end
        it 'finds a red on the second row' do
          expect(subject.check_slot(1, 2)).to eql :R
        end
      end
    end
  end

  describe '#drop_in' do
    it 'drops in Y(ellow) to an empty board' do
      subject.drop_in(:Y, 1)
      expect(subject.slots[0]).to eql :Y
    end

    it 'drops in Y(ellow) on top of a previous token' do
      subject.drop_in(:Y, 1)
      subject.drop_in(:Y, 1)
      expect(subject.slots[subject.COLUMNS * 1 + 0]).to eql :Y
    end

    it 'drops in a full column of R(ed) slots' do
      for drop_count in 0..subject.ROWS - 1 do
        subject.drop_in(:R, 1)
        expect(subject.slots[subject.COLUMNS * drop_count]).to eql :R
      end
    end

    it 'drops in a full board of Y(ellow) slots' do
      subject.COLUMNS.times do |column|
        for drop_count in 0..subject.ROWS - 1 do
          subject.drop_in(:Y, column + 1)
          expect(subject.slots[subject.COLUMNS * drop_count + column]).to eql :Y
        end
      end
    end
  end

  describe '#make_turn' do
    context 'Y(ellow) player starts' do
      before do
        allow(subject).to receive(:ask_where_to_drop).and_return(1)
      end

      it 'afters a move - R(ed) player gets a turn' do
        subject.make_turn
        expect(subject.turn_color).to eql :R
      end
      it 'after 2 moves - Y(ellow) player gets a turn again' do
        subject.make_turn
        subject.make_turn
        expect(subject.turn_color).to eql :Y
      end
      it 'makes the board have one less free space' do
        free_spaces = subject.slots.count(&:nil?)
        subject.make_turn
        expect(subject.slots.count(&:nil?)).to eql free_spaces - 1
      end
    end
  end

  describe '#check_if_won' do
    context '3 Y(ellow) slots in first column and 3 R(ed) slots in second column' do
      before do
        3.times { subject.drop_in(:Y, 1) }
        3.times { subject.drop_in(:R, 2) }
      end

      it 'finds a win when a 4th Y(ellow) is dropped in first column' do
        allow(subject).to receive(:ask_where_to_drop).and_return(1)
        subject.make_turn
        expect(subject.check_if_won([1, 4])).to eql true
      end
    end
  end

  # describe 'play' do
  #   before do
  #     3.times subject.drop_in(:Y, 1)
  #   end

  #   it 'stops when a player has won' do
  #     make_turn()
  #   end
  # end

end
