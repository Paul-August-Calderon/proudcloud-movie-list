require 'rails_helper'

RSpec.describe MoviesHelper, type: :helper do
  describe "#highlight_for_highest_rated_movie" do
    let(:highest_vote) { 10 }

    context "when the current_rating is equal to the highest rating" do
      let(:current_vote) { highest_vote }

      it "returns the expected tailwind class" do
        expect(helper.highlight_highest_rated(current_vote, highest_vote)).to eq("bg-green-300")
      end
    end

    context "when the current_rating is equal to the highest rating" do
      let(:current_vote) { highest_vote - 1 }
      it "returns nil" do
        expect(helper.highlight_highest_rated(current_vote, highest_vote)).to be_nil
      end
    end
  end
end
