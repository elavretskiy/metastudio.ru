# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'faker'

FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word }

    trait :name_static do
      name 'tag'
    end
  end
end
