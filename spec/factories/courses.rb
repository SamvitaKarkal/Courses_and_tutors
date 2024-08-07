FactoryBot.define do
  factory :course do
    name { "Default Course Name" }
    description { "Default Course Description" }

    trait :one do
      name { "Computer Science" }
      description { "This is the CS course." }
    end

    trait :two do
      name { "Data Science" }
      description { "This is the DS course." }
    end
  end
end
