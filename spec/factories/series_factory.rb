FactoryGirl.define do
  factory :series, class: Dcm4chee::Series do |s|
    s.series_no { rand(10000) + 1 }
    s.source_aet { Faker::Company.name.upcase.gsub(/\s/, '_') }
    s.modality { ['CT', 'MR', 'CR', 'DR', 'OT'].sample }
    s.description { Faker::Lorem.paragraphs }
    s.num_instances 1
    s.availability { (0..3).to_a.sample }

    study
  end
end
