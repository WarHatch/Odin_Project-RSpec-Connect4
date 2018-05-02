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

  describe 'drop_in' do
    it 'drops in yellow to an empty board' do
      subject.drop_in(:Y, 1)
      expect(subject.slots[0]).to eql :Y
    end
  end

end
