# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :uploads, through: :taggings

  validates :name, presence: true, uniqueness: true

  scope :by_name, ->(name) { where(name: name.strip) }
  scope :counts, -> {
    select('name, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id, tags.name')
  }
end
