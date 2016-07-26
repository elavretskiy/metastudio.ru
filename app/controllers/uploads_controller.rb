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
    @upload = Upload.new
    authorize @upload
    current_user.uploads.create!(upload_params)
    render nothing: true
  end

  protected

  def collection
    get_collection_ivar || set_collection_ivar(apply_scopes(policy_scope(end_of_association_chain)).order(id: :desc).includes(:tags).page(params[:page]).per(10))
  end

  private

  def upload_params
    params.permit(policy(@upload).permitted_attributes)
  end
end
