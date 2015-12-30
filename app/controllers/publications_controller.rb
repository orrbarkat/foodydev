class PublicationsController < ApplicationController
  before_action :set_publication, only: [:update, :destroy]
  before_action :set_date, only: [:create]
  after_action :pushCreate, only: [:create]
  after_action :pushDelete, only: [:destroy] 

  def home
    @publications = Publication.all
  end
  
  def index
    dti=(Time.now).to_i
    render json: Publication.where( "is_on_air=? AND starting_date<=? AND ending_date>=?", true, dti, dti)
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    use_date
    @publication.save!
    puts "two"
    render json: @publication, only: [:id, :version]
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def update
    @publication.update!(publication_params)
    if @publication.is_on_air == false
      pushDelete(@publication)
    end
    render json: @publication, only: [:id, :version]
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def destroy
    @publication.destroy
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

  def pushCreate
    require ENV["push_path"]
    puts @publication.id
    push = Push.new(@publication)
    push.create
  rescue => e
    logger.warn "Unable to push, will ignore: #{e}"
  end

  def pushDelete
    require ENV["push_path"]
    puts @publication.id
    push = Push.new(@publication)
    puts push
    push.delete
  rescue => e
    logger.warn "Unable to push, will ignore: #{e}"
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
    params.require(:publication).permit(:version, :title, :subtitle, :address, :type_of_collecting, :latitude, :longitude, :starting_date, :ending_date, :contact_info, :is_on_air, :active_device_dev_uuid, :photo_url)
  end
end
