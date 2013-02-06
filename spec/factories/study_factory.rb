FactoryGirl.define do
  factory :study, class: Dcm4chee::Study do |s|
    s.study_at { rand(30).days.ago.to_time }
    s.description { Faker::Lorem.sentence }
    s.num_series 1
    s.num_instances 1
    s.availability { (0..3).to_a.sample }

    patient
  end
end
