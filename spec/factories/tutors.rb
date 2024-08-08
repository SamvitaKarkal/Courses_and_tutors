FactoryBot.define do
  factory :tutor do
    name { 'Default Tutor Name' }

    trait :hyung do
      name { 'Hyung Me' }
      association :course, factory: %i[course one]
    end

    trait :rachel do
      name { 'Rachel Williams' }
      association :course, factory: %i[course one]
    end

    trait :john do
      name { 'John Frost' }
      association :course, factory: %i[course two]
    end
  end
end
