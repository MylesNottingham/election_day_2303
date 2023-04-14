class Candidate
  attr_reader :name,
              :party,
              :votes

  def initialize(info)
    @name = info[:name]
    @party = info[:party]
    @votes = 0
  end

  def vote_for!
    @votes += 1
  end
end
