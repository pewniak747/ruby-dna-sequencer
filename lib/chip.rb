class Chip
  attr_accessor :probes
  private :probes

  def initialize(probes)
    @probes = probes
  end

  def analyze(sequence)
    kmers = sequence.split(probe_length)
    kmers.each do |kmer|
      probes.each do |probe|
        probe.contact(kmer)
      end
    end
  end

  def spectrum
    probes.reject(&:zero?)
  end

  private

  def probe_length
    probes.first.length
  end
end
