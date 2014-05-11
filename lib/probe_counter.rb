class ProbeCounter
  attr_reader :count, :max_count
  private :max_count

  def initialize(max_count)
    @max_count = max_count
    @count = 0
  end

  def zero?
    count == 0
  end

  def more?
    count > max_count
  end

  def increment!
    @count += 1
  end
end
