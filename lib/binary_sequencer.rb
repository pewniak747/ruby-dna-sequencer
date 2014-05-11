class BinarySequencer

  class StackFrame
    attr_reader :sequence, :spectrums, :length

    def initialize(sequence, spectrums, length)
      @sequence = sequence
      @spectrums = spectrums
      @length = length
    end

    def next_frames
      anchor = sequence.last(length - 1)
      filtered = spectrums.map { |spectrum|
        spectrum.select { |probe|
          probe.kmer.first(length - 1) =~ anchor
        }.group_by { |p| p.kmer.nucleotides.last.code }
      }
      merged = filtered.first.merge(filtered.last) { |k, a, b| a + b }.select { |k, v| v.size == 2 }
      merged.map do |code, probes|
        nucleotide = Nucleotide.new(code)
        new_sequence = Sequence.new(sequence.nucleotides + [nucleotide])
        new_spectrums = spectrums.zip(probes).map { |spectrum, probe|
          if probe.more?
            spectrum
          else
            spectrum - [probe]
          end
        }
        StackFrame.new(new_sequence, new_spectrums, length)
      end
    end
  end

  attr_reader :chip, :anchor, :sequence_length, :kmer_length

  def initialize(chip, anchor, sequence_length)
    @chip = chip
    @anchor = anchor
    @sequence_length = sequence_length
    @kmer_length = anchor.length
  end

  def results
    results = []
    stack = [ StackFrame.new(anchor, chip.spectrums, kmer_length) ]

    until stack.empty? do
      current_frame = stack.pop
      current_frame.next_frames.each do |frame|
        if frame.sequence.length == sequence_length
          results << frame.sequence
        else
          stack << frame
        end
      end
    end

    results
  end
end
