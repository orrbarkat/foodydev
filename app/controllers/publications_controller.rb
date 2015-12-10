class PublicationsController < ApplicationController
  before_action :set_publication, only: [:update, :destroy]
  after_action :set_date, only: [:new]

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
    require ENV["push_path"]
    require ENV["gcm_path"]
    require 'houston'
    @publication = Publication.new(publication_params)
    @publication.starting_date = @start.to_i
    @publication.save!
    puts "two"
    push(@publication)
    puts "three"
    pushGcm(@publication)
    puts"four"
    render json: @publication, only: [:id, :version]
    puts "five"
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def update
    require ENV["push_path"]
    require 'houston'
    @publication.update!(publication_params)
    if @publication.is_on_air == false
      pushDelete(@publication)
    end
    render json: @publication, only: [:id, :version]
  rescue
    render json: @publication.errors, status: :unprocessable_entity
  end

  def destroy
    require ENV["push_path"]
    require 'houston'
    
    pushDelete(@publication)
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

  def set_date
    if params[:publication][:starting_date] == 0.0 
    @start = Time.new(params[:publication]["starting_date(1i)"].to_i,params[:publication]["starting_date(2i)"].to_i,params[:publication]["starting_date(3i)"].to_i,params[:publication]["starting_date(4i)"].to_i,params[:publication]["starting_date(5i)"].to_i)
    end
    if params[:publication][:ending_date] == 0.0 
    @end = Time.new(params[:publication]["ending_date(1i)"].to_i,params[:publication]["ending_date(2i)"].to_i,params[:publication]["ending_date(3i)"].to_i,params[:publication]["ending_date(4i)"].to_i,params[:publication]["ending_date(5i)"].to_i)
    end
  end

  def publication_params
    params.require(:publication).permit(:version, :title, :subtitle, :address, :type_of_collecting, :latitude, :longitude, :starting_date, :ending_date, :contact_info, :is_on_air, :active_device_dev_uuid, :photo_url)
  end
end
