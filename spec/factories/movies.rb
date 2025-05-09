FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    vote_average { Faker::Number.between(from: 1, to: 10) }
    vote_count { Faker::Number.number(digits: 4) }
  end
end
