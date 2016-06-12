class PublicationsController < ApplicationController
  before_action :set_publication, only: [:update, :destroy]
  before_action :set_date, only: [:create]
  # after_action :pushCreate, only: [:create]
  # after_action :pushDelete, only: [:destroy] 

  require ENV["push_path"]

  def home
    @publications = Publication.where("audience=?",0)
  end
  
  def index
    dti=(Time.now).to_i
    render json: Publication.where( "is_on_air=? AND starting_date<=? AND ending_date>=? AND audience=?", true, dti, dti, 0)
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    use_date
    @publication.save!
    CreatePublicationJob.perform_later(@publication.id)
    render json: @publication, only: [:id, :version]
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def update
    @publication.update!(publication_params)
    if @publication.is_on_air == false
      DeletePublicationJob.perform_later(@publication.id)
    end
    render json: @publication, only: [:id, :version] 
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def destroy
    @publication.update!(is_on_air:false, ending_date:0)
    DeletePublicationJob.perform_later(@publication.id)
    render json: "OK"
  end

  def show
    @publication = Publication.find(params[:id])
    render json: @publication
  end

  
private
  def set_publication
    @publication = Publication.find(params[:id])
  end

  def set_date
    if params[:publication][:starting_date].nil?
    @start = Time.new(params[:publication]["starting_date(1i)"].to_i,params[:publication]["starting_date(2i)"].to_i,params[:publication]["starting_date(3i)"].to_i,params[:publication]["starting_date(4i)"].to_i,params[:publication]["starting_date(5i)"].to_i)
    end
    if params[:publication][:ending_date].nil? 
    @end = Time.new(params[:publication]["ending_date(1i)"].to_i,params[:publication]["ending_date(2i)"].to_i,params[:publication]["ending_date(3i)"].to_i,params[:publication]["ending_date(4i)"].to_i,params[:publication]["ending_date(5i)"].to_i)
    end
  end

  def use_date
    if @publication.starting_date == 0.0
      @publication.starting_date = @start.to_i
      @publication.ending_date = @end.to_i
    end
  end

  def publication_params
    params.require(:publication).permit(:version, :title, :subtitle, :address, :type_of_collecting, :latitude, :longitude, :starting_date, :ending_date, :contact_info, :is_on_air, :active_device_dev_uuid, :photo_url, :publisher_id, :audience, :price, :price_description)
  end
end
