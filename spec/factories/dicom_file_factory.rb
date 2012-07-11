FactoryGirl.define do
  factory :dicom_file, class: Dcm4chee::DicomFile do |f|
    f.created_at { instance.created_at + 10.minute }
    f.size { rand(10000) }
    f.transfer_syntax_uid  { Faker.numerify('#.#.###.#####.#.#.#') }
    f.path do
      d = rand(30).days.ago
      '%s/%s/%s/%s' % [d.strftime('%Y/%m/%d'), Faker::Lorem.word.upcase, Faker::Lorem.word.upcase, Faker::Lorem.word.upcase]
    end
    f.availability { (-4..3).to_a.sample }

    instance
  end
end
