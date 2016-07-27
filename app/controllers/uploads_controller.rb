class UploadsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  respond_to :html, :js
  has_scope :by_tag

  def index
    authorize Upload
    index!
  end

  def create
    @upload = current_user.uploads.new
    @upload.assign_attributes(upload_params)
    authorize @upload
    create! do |format|
      format.html { render nothing: true }
      format.js { render nothing: true }
    end
  end

  protected

  def collection
    get_collection_ivar || set_collection_ivar(apply_scopes(policy_scope(end_of_association_chain)).index.page(params[:page]).per(10))
  end

  private

  def upload_params
    params.permit(policy(@upload).permitted_attributes)
  end
end
