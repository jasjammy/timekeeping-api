FactoryGirl.define do

  factory :time_card do
    username { Faker::Name.name }
    occurence { Date.today }
  end

end