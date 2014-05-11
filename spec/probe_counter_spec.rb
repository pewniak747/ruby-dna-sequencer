require_relative '../lib/probe_counter'

describe ProbeCounter do
  subject { ProbeCounter.new(1) }

  describe "fresh probe counter" do
    its(:zero?) { should be_true }
    its(:more?) { should be_false }
  end

  describe "#increment!" do
    it "is no more at zero" do
      subject.increment!
      expect(subject.zero?).to be_false
    end

    it "is not at more if incremented once" do
      subject.increment!
      expect(subject.more?).to be_false
    end

    it "is at more if incremented twice" do
      subject.increment!
      subject.increment!
      expect(subject.more?).to be_true
    end
  end
end
