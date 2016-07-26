require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  include Devise::TestHelpers

  describe 'GET #index' do
    before(:each) do
      @first_user = FactoryGirl.create(:user_with_uploads)
      @second_user = FactoryGirl.create(:user_with_uploads)
      sign_in @first_user
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'loads all of the uploads into @uploads' do
      get :index
      uploads = assigns(:uploads)
      expect(uploads.include?(@second_user.uploads.first)).to be false
      expect(uploads.count).to eq(3)
    end

    it 'loads all of the uploads into @uploads by tag' do
      tag = @first_user.tags.first.name
      get :index, { by_tag: tag }
      uploads = assigns(:uploads)
      expect(uploads.first.tags.exists?(name: tag)).to be true
      expect(uploads.count).to eq(1)
    end
  end

  describe 'authentication false' do
    it '#index false' do
      get :index
      expect(subject.current_user).to eq(nil)
      expect(response).to redirect_to new_user_session_path
    end

    it '#create false' do
      post :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
