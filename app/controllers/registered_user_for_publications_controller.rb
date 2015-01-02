class RegisteredUserForPublicationsController < ApplicationController
  before_action :set_registered_user_for_publication, only: [:show, :edit, :update, :destroy]

  # POST /registered_user_for_publications.json
  def create
    registered_user_for_publication = RegisteredUserForPublication.new(registered_user_for_publication_params)
    @registered_user_for_publication.save!
    render json: "OK"
  rescue
    render json: registered_user_for_publication.errors, status: :unprocessable_entity 
  end

  
private
  # Use callbacks to share common setup or constraints between actions.
  def set_registered_user_for_publication
    @registered_user_for_publication = RegisteredUserForPublication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registered_user_for_publication_params
    params.require(:registered_user_for_publication).permit(:publication_id, :date_of_registration, :active_device_dev_uuid)
  end
end