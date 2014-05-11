require_relative './kmer'
require_relative './nucleotide'

class Sequence < KMer
  def self.from_string(string)
    nucleotides = string.split(//).map { |c| Nucleotide.new(c.to_sym) }
    new(nucleotides)
  end

  def split(size)
    nucleotides.each_cons(size).map { |n| KMer.new(n) }
  end
end
