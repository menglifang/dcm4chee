FactoryGirl.define do
  factory :file_system, class: Dcm4chee::FileSystem do |s|
    s.path '/home/tower'
  end
end
