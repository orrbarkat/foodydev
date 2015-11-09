class RegisteredUserForPublicationsController < ApplicationController
  
  def create
    require ENV["push_path"]
    require 'houston'
    require ENV["gcm_path"]
    registered_user_for_publication = RegisteredUserForPublication.new(registered_user_for_publication_params)
    registered_user_for_publication.save!
    @publication = Publication.find(params[:publication_id])
    render json: registered_user_for_publication
    pushRegistered(@publication, registered_user_for_publication)
    pushGcmRegistered(@publication)
  rescue
    render json: registered_user_for_publication.errors, status: :unprocessable_entity 
  end

  def index
    if(params[:publication_id] == "1")
    render json: RegisteredUserForPublication.all
    else 
    @publication = Publication.find(params[:publication_id])
    @registered_user_for_publication = @publication.registered_user_for_publication
    render json: @registered_user_for_publication
    end
  end

  def destroy
    #@registered_user_for_publication = RegisteredUserForPublication.where(publication_id: params[:publication_id], publication_version: registered_user_for_publication_params[:publication_version], active_device_dev_uuid: registered_user_for_publication_params[:active_device_dev_uuid])
    @registered_user_for_publication = RegisteredUserForPublication.where(publication_id: params[:publication_id], publication_version: params[:publication_version], active_device_dev_uuid: params[:active_device_dev_uuid])
    @registered_user_for_publication.destroy_all
    render json: "OK"
  end
  
private
  # Use callbacks to share common setup or constraints between actions.
  def set_registered_user_for_publication
    @registered_user_for_publication = RegisteredUserForPublication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registered_user_for_publication_params
    params.require(:registered_user_for_publication).permit(:publication_id, :publication_version, :date_of_registration, :active_device_dev_uuid, :collector_contact_info, :collector_name)
  end
end
