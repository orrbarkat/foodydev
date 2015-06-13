class RegisteredUserForPublicationsController < ApplicationController
  
  def create
    registered_user_for_publication = RegisteredUserForPublication.new(registered_user_for_publication_params)
    registered_user_for_publication.save!
    render json: registered_user_for_publication
  rescue
    render json: registered_user_for_publication.errors, status: :unprocessable_entity 
  end

  def index
    @publication = Publication.find(params[:publication_id])
    @registered_user_for_publication = @publication.registered_user_for_publication
    render json: @registered_user_for_publication
  end

  def destroy
    render json: "OK"
  end  
  #def destroy
   # @registered_user_for_publication =  RegisteredUserForPublication.where(publication_id: params[:publication_id], publication_version: params[:publication_version], active_device_dev_uuid: params[:active_device_dev_uuid])
    #@registered_user_for_publication.destroy
    #render json: "OK"
  #end
  
private
  # Use callbacks to share common setup or constraints between actions.
  def set_registered_user_for_publication
    @registered_user_for_publication = RegisteredUserForPublication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registered_user_for_publication_params
    params.require(:registered_user_for_publication).permit(:publication_id, :publication_version, :date_of_registration, :active_device_dev_uuid)
  end
end
