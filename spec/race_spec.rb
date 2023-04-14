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
      expect(@race.open).to eq(true)
    end
  end

  describe "#register_candidate!" do
    it "can instantiate a canditate object and add it to candidates" do
      expect(@race.candidates).to eq([])
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      expect(@race.candidates).to eq([candidate_1])
      expect(candidate_1).to be_a(Candidate)
      expect(candidate_1.name).to eq("Diana D")
      expect(candidate_1.party).to eq(:democrat)
    end

    it "can instantiate another canditate object and add it to candidates" do
      expect(@race.candidates).to eq([])
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      expect(@race.candidates).to eq([candidate_1])
      candidate_2 = @race.register_candidate!({ name: "Roberto R", party: :republican })
      expect(@race.candidates).to eq([candidate_1, candidate_2])
    end
  end

  describe "#open?" do
    it "can return the boolean status of the open attribute" do
      expect(@race.open?).to eq(true)
    end
  end

  describe "#close!" do
    it "can change the boolean status of the open attribute to false" do
      expect(@race.open).to eq(true)
      @race.close!
      expect(@race.open).to eq(false)
    end
  end

  describe "#winner" do
    it "returns false if race is still open" do
      expect(@race.open?).to eq(true)
      expect(@race.winner).to eq(false)
    end

    it "can return the candidate with the most votes" do
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      candidate_2 = @race.register_candidate!({ name: "Roberto R", party: :republican })

      500.times { candidate_1.vote_for! }
      5.times { candidate_2.vote_for! }

      @race.close!
      expect(@race.open?).to eq(false)
      expect(@race.winner).to eq(candidate_1)
    end

    it "can return either candidate in the case of a tie" do
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      candidate_2 = @race.register_candidate!({ name: "Roberto R", party: :republican })

      50.times { candidate_1.vote_for! }
      50.times { candidate_2.vote_for! }

      @race.close!
      expect(@race.open?).to eq(false)
      expect(@race.winner).to eq(candidate_1 || candidate_2)
    end
  end

  describe "#tie?" do
    it "returns false if candidates have a different number votes" do
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      candidate_2 = @race.register_candidate!({ name: "Roberto R", party: :republican })

      500.times { candidate_1.vote_for! }
      5.times { candidate_2.vote_for! }

      @race.close!
      expect(@race.tie?).to eq(false)
    end

    it "returns true if candidates have the same number of votes" do
      candidate_1 = @race.register_candidate!({ name: "Diana D", party: :democrat })
      candidate_2 = @race.register_candidate!({ name: "Roberto R", party: :republican })

      50.times { candidate_1.vote_for! }
      50.times { candidate_2.vote_for! }

      @race.close!
      expect(@race.tie?).to eq(true)
    end
  end
end
