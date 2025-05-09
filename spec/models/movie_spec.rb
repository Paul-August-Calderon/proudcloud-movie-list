require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    context 'given valid parameters' do
      let(:title) { Faker::Movie.title }
      let(:vote_average) { Faker::Number.between(from: 1, to: 10) }
      let(:vote_count) { Faker::Number.number(digits: 4) }

      it 'allows saving of valid parameters' do
        expect(build(:movie, title:, vote_average:, vote_count:)).to be_valid
      end
    end

    context 'given invalid parameters' do
      it 'validates title to be present' do
        expect(build(:movie, title: nil)).not_to be_valid
      end

      it 'validates vote_average to be present' do
        expect(build(:movie, vote_average: nil)).not_to be_valid
      end

      it 'validates vote_count to be present' do
        expect(build(:movie, vote_count: nil)).not_to be_valid
      end

      it 'validates vote_average to be positive' do
        expect(build(:movie, vote_average: Faker::Number.negative)).not_to be_valid
      end

      it 'validates vote_count to be positive' do
        expect(build(:movie, vote_count: Faker::Number.negative)).not_to be_valid
      end
    end
  end
end
