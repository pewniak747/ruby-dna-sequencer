require_relative '../lib/nucleotide'

describe Nucleotide do
  subject { Nucleotide.new(:A, [:T]) }

  its(:code) { should be(:A) }

  describe "equality" do
    it "is equal with the same code" do
      expect(subject == Nucleotide.new(:A)).to be_true
    end

    it "is not equal with different code" do
      expect(subject == Nucleotide.new(:C)).to be_false
    end
  end

  describe "#complementary?" do
    it "is true for nucleotide with complementary code" do
      expect(subject.complementary?(Nucleotide.new(:T))).to be_true
    end

    it "is false for nucleotide with not complementary code" do
      expect(subject.complementary?(Nucleotide.new(:G))).to be_false
    end
  end

  describe "default complementaries" do
    let(:adenine) { Nucleotide.new(:A) }
    let(:thymine) { Nucleotide.new(:T) }
    let(:cytosine) { Nucleotide.new(:C) }
    let(:guanine) { Nucleotide.new(:G) }

    it "adenine complementary only with thymine" do
      expect(adenine.complementary?(adenine)).to be_false
      expect(adenine.complementary?(thymine)).to be_true
      expect(adenine.complementary?(cytosine)).to be_false
      expect(adenine.complementary?(guanine)).to be_false
    end

    it "thymine complementary only with adenine" do
      expect(thymine.complementary?(adenine)).to be_true
      expect(thymine.complementary?(thymine)).to be_false
      expect(thymine.complementary?(cytosine)).to be_false
      expect(thymine.complementary?(guanine)).to be_false
    end

    it "cytosine complementary only with guanine" do
      expect(cytosine.complementary?(adenine)).to be_false
      expect(cytosine.complementary?(thymine)).to be_false
      expect(cytosine.complementary?(cytosine)).to be_false
      expect(cytosine.complementary?(guanine)).to be_true
    end

    it "guanine complementary only with citosine" do
      expect(guanine.complementary?(adenine)).to be_false
      expect(guanine.complementary?(thymine)).to be_false
      expect(guanine.complementary?(cytosine)).to be_true
      expect(guanine.complementary?(guanine)).to be_false
    end
  end
end
