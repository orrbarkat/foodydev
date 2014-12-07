class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  def index
    render json: Publication.all
  end

  def create
		publication = Publication.create!(publication_params)
    render json: publication
  rescue
    render json: publication.errors, status: :unprocessable_entity
  end

  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Publication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:publication_version, :publication_title, :publication_address, :publication_type_of_collecting, :publication_latitude, :publication_longitude, :publication_starting_date, :publication_ending_date, :publication_contact_info, :is_on_air, :reporting_device_uuid, :app_id)
    end
end
