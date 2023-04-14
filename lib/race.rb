class Race
  attr_reader :office,
              :candidates,
              :open

  def initialize(office)
    @office = office
    @candidates = []
    @open = true
  end

  def register_candidate!(info)
    candidate = Candidate.new(info)
    @candidates << candidate
    candidate
  end

  def open?
    @open
  end

  def close!
    @open = false
  end

  def winner
    return false if @open

    candidates.max_by(&:votes)
  end

  def tie?
    top_two = candidates.map(&:votes).max(2)
    top_two.first == top_two.last
  end
end
