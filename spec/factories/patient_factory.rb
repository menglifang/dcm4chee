FactoryGirl.define do
  factory :patient, class: Dcm4chee::Patient do |p|
    p.pid { rand(100) }
    p.pid_issuer { Faker::Lorem.word.upcase }
    p.name { Faker::Name.name }
    p.birthday { (rand(50) + 1).years.ago.to_date }
    p.gender { ['M', 'F'].sample }
  end
end
