require_relative '../lib/kmer'

describe KMer do
  subject { KMer.new(nucleotides) }

  let(:nucleotides) { [double(:nucleotide)] }

  its(:length) { should == 1 }

  describe "equality" do
    it "is equal to the same sequence of nucleotides" do
      expect(subject == KMer.new(nucleotides)).to be_true
    end

    it "is not equal to different sequence of nucleotides" do
      expect(subject == KMer.new([ double(:nucleotide) ])).to be_false
    end
  end

  describe "match" do
    it "is true for the same sequence of nucleotides" do
      expect(subject =~ KMer.new(nucleotides)).to be_true
    end

    it "is false for different sequence of nucleotides" do
      expect(subject =~ KMer.new([ double(:nucleotide) ])).to be_false
    end
  end
end
