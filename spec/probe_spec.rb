require_relative '../lib/probe'

describe Probe do
  subject { Probe.new(kmer, 1) }
  let(:kmer) { double(:kmer) }

  its(:kmer) { should be(kmer) }

  describe "counter" do
    it "delegates #zero? to counter" do
      expect(subject.zero?).to be_true
    end

    it "delegates #more? to counter" do
      expect(subject.more?).to be_false
    end
  end
end
