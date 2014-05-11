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

  describe "#contact" do
    let(:other_kmer) { double(:kmer) }

    describe "with matching kmer" do
      before do
        allow(kmer).to receive(:=~).with(other_kmer).and_return(true)
      end

      it "increments the probe" do
        subject.contact(other_kmer)
        expect(subject.zero?).to be_false
      end
    end

    describe "with not matching kmer" do
      before do
        allow(kmer).to receive(:=~).with(other_kmer).and_return(false)
      end

      it "does not increment the probe" do
        subject.contact(other_kmer)
        expect(subject.zero?).to be_true
      end
    end
  end
end
