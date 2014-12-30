class ActiveDevicesController < ApplicationController
  before_action :set_active_device, only: [:show, :edit, :update, :destroy]

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
    active_device = ActiveDevice.new(active_device_params)
    active_device.save!
    render json: active_device
  rescue
    render json: active_device.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /active_devices/1
  # PATCH/PUT /active_devices/1.json
  def update
      active_device = Active_device.update!(active_device_params)
      render json: active_device
  rescue
      render json: active_device.errors, status: :unprocessable_entity
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_device
      @active_device = ActiveDevice.find(params[:id])
    end

  # DELETE /active_devices/1
  # DELETE /active_devices/1.json
 #def destroy
  #  @active_device.destroy
 #end


    # Never trust parameters from the scary internet, only allow the white list through.
    def active_device_params
      params.require(:active_device).permit(:remote_notification_token, :is_ios, :last_location_latitude, :last_location_longitude, :dev_uuid)
    end
end
