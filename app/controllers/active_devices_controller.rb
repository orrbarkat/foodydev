class ActiveDevicesController < ApplicationController
  #before_action :set_active_device, only: [:show, :edit,  :destroy]

  # GET /active_devices
  # GET /active_devices.json
  def index
    render json: ActiveDevice.all
  end

  # GET /active_devices/1/edit
  def edit
  end

  # POST /active_devices
  # POST /active_devices.json
  def create
    active_device = ActiveDevice.find_by_dev_uuid(active_device_params[:dev_uuid])
      if active_device == nil
        active_device = ActiveDevice.new(active_device_params)
        else 
        active_device.update!(active_device_params)
      end
      active_device.save!
    render json: active_device
  rescue
    render json: active_device.errors, status: :unprocessable_entity
  end

  
  def update
    active_device = ActiveDevice.find_by_dev_uuid(active_device_params[:dev_uuid])
    if active_device==nil
      render :json => {:error => "not-found"}.to_json, :status => 404
      else 
      active_device.update!(active_device_params)
      render json: active_device
    end
    rescue
    render json: active_device.errors, status: :unprocessable_entity
  end


private
  #Use callbacks to share common setup or constraints between actions.
  def set_active_device
    @active_device = ActiveDevice.find_by_dev_uuid(active_device_params[:dev_uuid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def active_device_params
    params.require(:active_device).permit(:remote_notification_token, :is_ios, :last_location_latitude, :last_location_longitude, :dev_uuid)
  end

end