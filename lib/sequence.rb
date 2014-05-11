require_relative './kmer'
require_relative './nucleotide'

class Sequence < KMer
  def split(size)
    nucleotides.each_cons(size).map { |n| KMer.new(n) }
  end

  def self.from_string(string)
    nucleotides = string.split(//).map { |c| Nucleotide.new(c.to_sym) }
    new(nucleotides)
  end

  def self.random(count)
    new(Array.new(count) { Nucleotide.default.sample })
  end
end
