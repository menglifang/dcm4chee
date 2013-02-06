FactoryGirl.define do
  factory :instance, class: Dcm4chee::Instance do |i|
    i.created_at { series.created_at + 5.minute }
    i.instance_no { rand(100) + 1 }
    i.sop_class_uid { Faker.numerify('#.#.###.#####.#.#.#.#.#.#') }
    i.availability { (0..3).to_a.sample }

    series
  end
end
