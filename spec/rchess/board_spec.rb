require 'spec_helper'

describe Rchess::Board do
  describe '.new' do
    let(:boxes) do
     [
       [:R, :C, :B, :Q, :K, :B, :C, :R],
       [:P, :P, :P, :P, :P, :P, :P, :P],
       ["", "", "", "", "", "", "", ""],
       ["", "", "", "", "", "", "", ""],
       ["", "", "", "", "", "", "", ""],
       ["", "", "", "", "", "", "", ""],
       [:p, :p, :p, :p, :p, :p, :p, :p],
       [:r, :c, :b, :q, :k, :b, :c, :r]
     ]
    end
    subject{ described_class.new }

    it 'initialize a new board' do
      subject.boxes.should eq  boxes
    end

    it 'initialize the loosed pieces' do
      Rchess::Piece::COLORS.keys.each do |color|
        subject.loosed_pieces[color].should eq []
      end
    end
  end

  describe '#movement_within_board?(srcCoord, dstCoord)' do
    let(:srcCoord){ Rchess::Coord.new({ x: 1, y: 1 }) }
    let(:dstCoord){ Rchess::Coord.new({ x: 1, y: 2 }) }

    subject{ described_class.new.movement_within_board?(srcCoord, dstCoord) }

    it 'returns true if src and desc are withing the board' do
      expect(subject).to be_true
    end

    context 'when dstCoord is outside the board' do
      it 'returns false' do
        board = described_class.new

        [described_class::BOUNDARIES.last+1, described_class::BOUNDARIES.first-1].each do |outcoord|
          board.movement_within_board?(srcCoord, Rchess::Coord.new( {x: 1, y: outcoord} )).should be_false
          board.movement_within_board?(srcCoord, Rchess::Coord.new( {x: outcoord, y: 1} )).should be_false
        end
      end
    end
  end

  describe '#box_at_coord(coord)' do
    it 'return the value of the baord at the coord' do
      board = described_class.new
      {0 => :r, 1 => :c, 2 => :b}.each do |k,v|
        board.box_at_coord(Rchess::Coord.new({ x: k, y: described_class::BOUNDARIES.last-1 })).should eq v
        board.box_at_coord(Rchess::Coord.new({ x: k, y: described_class::BOUNDARIES.last-2 })).should eq :p
      end
    end
  end

  describe '#piece_at_coord(coord)' do
    let(:board){ described_class.new }

    context 'when the box is empty' do
      let(:coord){ Rchess::Coord.new({ x: 1, y: 3 }) }

      it 'returns nil' do
        board.box_at_coord(coord).should eq described_class::EMPTY_BOX
        board.piece_at_coord(coord).should be_nil
      end
    end

    context 'when the box is not empty' do
      let(:coord){ Rchess::Coord.new({ x: 1, y: 1 }) }

      it 'returns a piece' do
        board.box_at_coord(coord).should_not eq described_class::EMPTY_BOX
        board.piece_at_coord(coord).should be_instance_of Rchess::Piece
      end
    end
  end

  describe '#coord_for_type_and_color(type, color)' do
    let(:board){ described_class.new }

    it 'returns the coord for the specified type and color' do
      board.coord_for_type_and_color(:k, :black).should == Rchess::Coord.new({ x: 4, y: 0 })
      board.coord_for_type_and_color(:k, :white).should == Rchess::Coord.new({ x: 4, y: 7 })
    end
  end
end
