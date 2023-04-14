require "./lib/candidate"
require "./lib/election"
require "./lib/race"

RSpec.describe Election do
  before(:each) do
    @election = Election.new("2023")
    @race = Race.new("Texas Governor")
    @candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
    @candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
  end

  describe "#initialize" do
    it "can initialize an electin with attributes" do
      expect(@election).to be_a(Election)
      expect(@election.year).to eq("2023")
      expect(@election.races).to eq([])
    end
  end

  describe "#add_race" do
    it "can add a race to races" do
      expect(@election.races).to eq([])
      expect(@election.add_race(@race)).to eq([@race])
      expect(@election.races).to eq([@race])
    end
  end

  describe "#candidates" do
    it "can return all candidate objects in race" do
      expect(@election.candidates).to eq([])
      @election.add_race(@race)
      expect(@election.candidates).to eq([@candidate1, @candidate2])
    end
  end

  describe "#vote_counts" do
    it "can return a hash with each candidate's name as key and the vote count as value" do
      @election.add_race(@race)
      expect(@election.candidates).to eq([@candidate1, @candidate2])

      expect(@candidate1.name).to eq("Diana D")
      expect(@candidate1.party).to eq(:democrat)
      expect(@candidate1.votes).to eq(0)
      expect(@candidate2.name).to eq("Roberto R")
      expect(@candidate2.party).to eq(:republican)
      expect(@candidate2.votes).to eq(0)

      500.times { @candidate1.vote_for! }
      5.times { @candidate2.vote_for! }

      expect(@candidate1.votes).to eq(500)
      expect(@candidate2.votes).to eq(5)

      expect(@election.vote_counts).to eq({"Diana D" => 500, "Roberto R" => 5})
    end
  end
end
