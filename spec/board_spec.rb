require 'board'

describe Board do
  describe new do
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
    it 'drops in yellow to an empty board' do
      subject.drop_in(:Y, 1)
      expect(subject.slots[0]).to eql :Y
    end

    it 'drops in yellow on top of a previous token' do
      subject.drop_in(:Y, 1)
      subject.drop_in(:Y, 1)
      expect(subject.slots[subject.COLUMNS * 1 + 0]).to eql :Y
    end
  end

end
