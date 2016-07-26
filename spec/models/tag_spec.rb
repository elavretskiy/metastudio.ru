# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'user tags counts with static tag name' do
    user = FactoryGirl.create(:user_with_uploads, :all_tags_static)
    tags = user.tags.counts

    expect(tags.length).to eq(1)
    expect(tags[0].count).to eq(9)
    expect(tags[0].name).to eq('tag')
  end

  it 'user tags counts with dynamic tag name' do
    user = FactoryGirl.create(:user_with_uploads)
    tags = user.tags.counts

    expect(tags.length).to eq(3)
    expect(tags[0].count).to eq(1)
  end
end
