require 'spec_helper'

describe Rchess::Coord do
  describe '.new(h)' do
    it 'raise ArgumentError if x and y are not provided' do
      expect{ described_class.new({})}.to raise_error(ArgumentError)
      expect{ described_class.new({x: 1})}.to raise_error(ArgumentError)
      expect{ described_class.new({y: 1})}.to raise_error(ArgumentError)
      expect{ described_class.new({x: 1, y: 1})}.not_to raise_error(ArgumentError)
    end
  end

  describe '#apply_delta(delta)' do
    let(:coord){ described_class.new({ x: 1, y: 1 }) }
    let(:delta){ { x: 1, y: 1 } }

    subject{ coord.apply_delta(delta) }

    it 'return a new coord at delta' do
      subject.should be_instance_of described_class
      subject.x.should eq coord.x + delta[:x]
      subject.y.should eq coord.y + delta[:y]
    end
  end

  describe '#to_hash' do
    let(:coord){ { x: 1, y: 1 } }

    subject{ described_class.new(coord).to_hash }
    it 'return a hash with the coords' do
      expect(subject[:x]).to eq coord[:x]
      expect(subject[:y]).to eq coord[:y]
    end
  end
end
