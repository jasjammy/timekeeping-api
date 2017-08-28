FactoryGirl.define do
  factory :time_entry do
    trait :eleven_am do
      time DateTime.now.change({ hour: 11, min: 0, sec: 0 })
    end

    trait :four_thirty_pm do
      time DateTime.now.change({ hour: 16, min: 30, sec: 0 })
    end

    trait :five_forty_five_pm do
      time DateTime.now.change({ hour: 17, min: 45, sec: 0 })
    end

    trait :seven_forty_five_pm do
      time DateTime.now.change({ hour: 19, min: 45, sec: 0 })
    end
  end

end