class KMer
  attr_reader :nucleotides

  def initialize(nucleotides)
    @nucleotides = nucleotides
  end

  def length
    nucleotides.length
  end

  def ==(other)
    nucleotides == other.nucleotides
  end

  def =~(other)
    self == other
  end

  def to_s
    nucleotides.map(&:code).join
  end
end
