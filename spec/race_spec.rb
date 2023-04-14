require "./lib/candidate"
require "./lib/race"

RSpec.describe Race do
  before(:each) do
    @race = Race.new("Texas Governor")
  end

  describe "#initialize" do
    it "can initialize a race with attributes" do
      expect(@race).to be_a(Race)
      expect(@race.office).to eq("Texas Governor")
      expect(@race.candidates).to eq([])
    end
  end

  describe "#register_candidate!" do
    it "can instantiate a canditate object and add it to candidates" do
      expect(@race.candidates).to eq([])
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      expect(@race.candidates).to eq([candidate1])
      expect(candidate1).to be_a(Candidate)
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
    end

    it "can instantiate another canditate object and add it to candidates" do
      expect(@race.candidates).to eq([])
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      expect(@race.candidates).to eq([candidate1])
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      expect(@race.candidates).to eq([candidate1, candidate2])
    end
  end
end
