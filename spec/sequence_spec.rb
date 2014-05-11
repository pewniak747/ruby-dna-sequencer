require_relative '../lib/sequence'
require_relative '../lib/kmer'

describe Sequence do
  subject { Sequence.new(nucleotides) }

  let(:nucleotides) { [ double(:nucleotide) ] }

  describe ".from_string" do
    subject { Sequence.from_string("ACGTA") }

    it "constructs sequence of 5 nucleotides" do
      expect(subject.length).to eq(5)
    end

    it "constructs sequence of correct nucleotides" do
      codes = [:A, :C, :G, :T, :A]
      expect(subject.nucleotides.map(&:code)).to eq(codes)
    end
  end

  describe "#split" do
    subject { sequence.split(3) }

    let(:sequence) { Sequence.new(nucleotides) }
    let(:nucleotides) { Array.new(5) { double(:nucleotide) } }

    its(:length) { should eq(3) }

    it "returns correct k-mers" do
      expect(subject[0]).to eq(KMer.new(nucleotides[0..2]))
      expect(subject[1]).to eq(KMer.new(nucleotides[1..3]))
      expect(subject[2]).to eq(KMer.new(nucleotides[2..4]))
    end
  end
end
