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

class Upload < ActiveRecord::Base
  has_attached_file :file
  do_not_validate_attachment_file_type :file

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :object, polymorphic: true

  validates :object_id, :object_type, presence: true

  scope :by_tag, ->(tag) { joins(:tags).where(tags: { name: tag }) }
  scope :index, -> { order(id: :desc).includes(:tags) }

  def all_tags=(names)
    self.tags = names.split(',').map { |name| Tag.by_name(name).first_or_create! }
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def filename
    file.original_filename
  end

  def fileurl
    file.url
  end
end
