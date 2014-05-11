require_relative '../lib/chip'

describe Chip do
  subject { Chip.new(probes) }

  let(:probes) { [ probe1, probe2 ] }
  let(:probe1) { double(:probe, length: 3) }
  let(:probe2) { double(:probe, length: 3) }

  describe "#spectrum" do
    it "returns only non-zero probes" do
      expect(probe1).to receive(:zero?).and_return(true)
      expect(probe2).to receive(:zero?).and_return(false)
      expect(subject.spectrum).to match_array([probe2])
    end
  end

  describe "#analyze" do
    let(:sequence) { double(:sequence, split: [ kmer1, kmer2 ]) }
    let(:kmer1) { double(:kmer) }
    let(:kmer2) { double(:kmer) }

    before do
      expect(probe1).to receive(:contact).with(kmer1)
      expect(probe1).to receive(:contact).with(kmer2)
      expect(probe2).to receive(:contact).with(kmer1)
      expect(probe2).to receive(:contact).with(kmer2)
    end

    it "contacts all k-mers with probes" do
      subject.analyze(sequence)
    end
  end
end
