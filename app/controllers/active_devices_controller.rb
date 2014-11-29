class ActiveDevicesController < ApplicationController
  before_action :set_active_device, only: [:show, :edit, :update, :destroy]

  # GET /active_devices
  # GET /active_devices.json
  def index
    @active_devices = ActiveDevice.all
  end

  # GET /active_devices/1
  # GET /active_devices/1.json
  def show
  end

  # GET /active_devices/new
  def new
    @active_device = ActiveDevice.new
  end

  # GET /active_devices/1/edit
  def edit
  end

  # POST /active_devices
  # POST /active_devices.json
  def create
    @active_device = ActiveDevice.new(active_device_params)

    respond_to do |format|
      if @active_device.save
        format.html { redirect_to @active_device, notice: 'Active device was successfully created.' }
        format.json { render :show, status: :created, location: @active_device }
      else
        format.html { render :new }
        format.json { render json: @active_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /active_devices/1
  # PATCH/PUT /active_devices/1.json
  def update
    respond_to do |format|
      if @active_device.update(active_device_params)
        format.html { redirect_to @active_device, notice: 'Active device was successfully updated.' }
        format.json { render :show, status: :ok, location: @active_device }
      else
        format.html { render :edit }
        format.json { render json: @active_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /active_devices/1
  # DELETE /active_devices/1.json
  def destroy
    @active_device.destroy
    respond_to do |format|
      format.html { redirect_to active_devices_url, notice: 'Active device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_device
      @active_device = ActiveDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_device_params
      params.require(:active_device).permit(:remote_notification_token, :is_ios, :last_location_latitude, :last_location_longitude, :device_uuid)
    end
end
