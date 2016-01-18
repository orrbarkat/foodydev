class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    op=0
    
    if (params[:identity_provider].downcase == "google")
      if (User.find_by_identity_provider_email(params[:identity_provider_email].downcase))
        @user = User.find_by_identity_provider_email(params[:identity_provider_email].downcase)
        op=1
      end
    elsif (User.find_by_identity_provider_user_id(params[:identity_provider_id]))
      @user = User.find_by_identity_provider_id(params[:identity_provider_id])
      op=1
    end

    if (op==0)
      @user = User.new(user_params)
      @user.identity_provider_email.downcase!
      respond_to do |format|
        if @user.save 
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
    
    if(op==1)
      respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to @user, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end  
    end    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:identity_provider, :identity_provider_user_id, :identity_provider_token, :phone_number, :identity_provider_email, :identity_provider_user_name, :is_logged_in, :active_device_dev_uuid, :ratings, :cradits, :foodies)
    end
end
