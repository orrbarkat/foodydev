class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_params, only: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/groups
  def get_groups_for_user
    @group_member_db_line = Array.new
    @group_member_db_line = GroupMember.where("user_id = ?", params[:id])
    @array_to_send = Array.new

    @group_member_db_line.each do |m|
        temp_id = m[:Group_id]
        temp = Hash.new()
        group = Group.find(temp_id)
        if(group)
          temp["group_id"] = temp_id
          temp["group_name"] = group[:name]
    #       temp["user_id"] = group[:user_id]
    #       temp["members"] = GroupMember.where("Group_id = ?", temp_id)
          @array_to_send << temp
        end
    end
    render json: @array_to_send
   
    # respond_to do |format|
      
    #     format.html { redirect_to @array_to_send, notice: 'Groups were successfully found.' }
    #     format.json { render json: @array_to_send } 
    # end

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
    @user = User.new(user_params)
    @user.identity_provider_email.downcase!
    
      if (User.find_by_identity_provider_email(@user.identity_provider_email))
        @user = User.find_by_identity_provider_email(@user.identity_provider_email)
        op=1
      end

    if (op==0)
 
      
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
