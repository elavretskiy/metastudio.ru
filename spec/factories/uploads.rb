# == Schema Information
#
# Table name: uploads
#
#  id                :integer          not null, primary key
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  object_id         :integer          not null
#  object_type       :string           not null
#

require 'faker'

FactoryGirl.define do
  factory :upload do
    file_file_name { Faker::File.file_name }
    file_content_type { Faker::File.mime_type }
    file_file_size { Faker::Number.number(5) }
    file_updated_at { Time.current }
    all_tags { Faker::Lorem.word }
    association :object, factory: :user

    trait :all_tags_static do
      all_tags 'tag'
    end

    trait :all_tags_list do
      all_tags { 'tag1, tag2, tag3' }
    end
  end
end
