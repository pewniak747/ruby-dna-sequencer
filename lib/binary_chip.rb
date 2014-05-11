require_relative './nucleotide'
require_relative './kmer'
require_relative './probe'
require_relative './chip'

class BinaryChip
  attr_reader :kmer_length, :ws_chip, :ry_chip

  def initialize(kmer_length)
    @kmer_length = kmer_length

    @ws_chip = prepare_ws_chip
    @ry_chip = prepare_ry_chip
  end

  def analyze(sequence)
    ws_chip.analyze(sequence)
    ry_chip.analyze(sequence)
  end

  def spectrum
    spectrums.flatten(1)
  end

  def spectrums
    [ ws_chip.spectrum, ry_chip.spectrum ]
  end

  private

  def prepare_ws_chip
    weak = Nucleotide.new(:W, [], [:A, :T])
    strong = Nucleotide.new(:S, [], [:C, :G])
    prepare_chip([weak, strong])
  end

  def prepare_ry_chip
    purines = Nucleotide.new(:R, [], [:A, :G])
    pyrimidines = Nucleotide.new(:Y, [], [:T, :C])
    prepare_chip([purines, pyrimidines])
  end

  def prepare_chip(seed)
    probes = seed.repeated_permutation(kmer_length - 1).map { |nucleotides|
      Nucleotide.default.map { |nucleotide| nucleotides + [nucleotide] }
    }.flatten(1).map { |nucleotides|
      Probe.new(KMer.new(nucleotides), 1)
    }
    Chip.new(probes)
  end
end
