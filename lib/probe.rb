require_relative './probe_counter'

class Probe
  attr_reader :kmer, :counter
  private :counter

  def initialize(kmer, max_count)
    @kmer = kmer
    @counter = ProbeCounter.new(max_count)
  end

  def zero?
    counter.zero?
  end

  def more?
    counter.more?
  end
end
