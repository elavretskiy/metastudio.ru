class UploadPolicy < ApplicationPolicy
  def index?
    true
  end

  def permitted_attributes
    [:file, :object_id, :object_type, :file_file_name, :all_tags]
  end

  class Scope < Scope
    def resolve
      @user.uploads
    end
  end
end
