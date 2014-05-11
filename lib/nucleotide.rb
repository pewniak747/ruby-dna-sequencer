class Nucleotide
  attr_reader :code, :complementaries
  private :complementaries

  def initialize(code, complementaries = nil)
    @code = code
    @complementaries = complementaries || default_complementaries.fetch(code)
  end

  def ==(other)
    code == other.code
  end

  def complementary?(other)
    complementaries.include?(other.code)
  end

  def self.default
    default_complementaries.keys.map { |c| new(c) }
  end

  private

  def default_complementaries
    self.class.default_complementaries
  end

  def self.default_complementaries
    {
      A: [:T],
      T: [:A],
      C: [:G],
      G: [:C]
    }
  end
end
