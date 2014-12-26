class RegisteredUserForPublicationsController < ApplicationController
  before_action :set_registered_user_for_publication, only: [:show, :edit, :update, :destroy]

  # GET /registered_user_for_publications
  # GET /registered_user_for_publications.json
  #def index
  # render json: RegisteredUserForPublication.all
  #end


  # POST /registered_user_for_publications
  # POST /registered_user_for_publications.json
  def create
    registered_user_for_publication = RegisteredUserForPublication.create(registered_user_for_publication_params)
    #render json: registered_user_for_publication
    render json: "OK"
  rescue
    render json: registered_user_for_publication.errors, status: :unprocessable_entity 
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registered_user_for_publication
      @registered_user_for_publication = RegisteredUserForPublication.find(params[:id])
    end

  # PATCH/PUT /registered_user_for_publications/1
  # PATCH/PUT /registered_user_for_publications/1.json
    def update
      registered_user_for_publication = Registered_user_for_publication.update!(registered_user_for_publication_params)
      render json:  registered_user_for_publication
    rescue
      render json: registered_user_for_publication.errors, status: :unprocessable_entity 
      end
    end

  # DELETE /registered_user_for_publications/1.json
    def destroy
     @registered_user_for_publication.destroy
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def registered_user_for_publication_params
      params.require(:registered_user_for_publication).permit(:publication_unique_id, :date_of_registration, :device_uuid)
    end
end
