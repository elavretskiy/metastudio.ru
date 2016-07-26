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

require 'rails_helper'

RSpec.describe Upload, type: :model do
  it 'upload join all_tags' do
    upload = FactoryGirl.create(:upload)
    upload.all_tags=('tag1, tag2, tag3')
    tags = upload.tags

    expect(tags.exists?(name: 'tag1')).to be true
    expect(tags.exists?(name: 'tag2')).to be true
    expect(tags.exists?(name: 'tag3')).to be true
  end

  it 'upload display all_tags' do
    upload = FactoryGirl.create(:upload, :all_tags_list)
    tags = upload.tags

    expect(tags.count).to eq(3)
    expect(upload.all_tags).to eq('tag1, tag2, tag3')
  end
end
