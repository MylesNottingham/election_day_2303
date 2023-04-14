require "./lib/candidate"

RSpec.describe Candidate do
  before(:each) do
    @diana = Candidate.new({ name: "Diana D", party: :democrat })
  end

  describe "#initialize" do
    it "can initialize a candidate with attributes" do
      expect(@diana).to be_a(Candidate)
      expect(@diana.name).to eq("Diana D")
      expect(@diana.party).to eq(:democrat)
      expect(@diana.votes).to eq(0)
    end
  end

  describe "#vote_for!" do
    it "can add a vote to votes" do
      expect(@diana.votes).to eq(0)
      @diana.vote_for!
      expect(@diana.votes).to eq(1)
      @diana.vote_for!
      expect(@diana.votes).to eq(2)
      @diana.vote_for!
      expect(@diana.votes).to eq(3)
      @diana.vote_for!
      expect(@diana.votes).to eq(4)
    end
  end
end
