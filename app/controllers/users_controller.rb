class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :get_groups_for_user]
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
<<<<<<< HEAD
    group_ids = GroupMember.where(user_id: @user.id).map{|member| member.Group_id} 
    groups = (@user.groups + Group.where(id: group_ids)) 
    groups_with_members = []
    groups.each do |group|
      members = group.group_members.to_a
      temp = group.attributes
      temp[:members] = members
      groups_with_members << temp
    end
    render json: groups_with_members



    # @group_member_db_line = GroupMember.where("user_id = ?", params[:id])
    # @array_to_send = Array.new

    # @group_member_db_line.each do |m|
    #     temp_id = m[:Group_id]
    #     temp = Hash.new
    #     group = Group.find_by_id(temp_id)
    #     if(group)
    #       temp["group_id"] = temp_id
    #       temp["group_name"] = group[:name]
    #       temp["user_id"] = group[:user_id]
          
    #       temp["members"] = GroupMember.where(:Group_id => temp_id)
    #       @array_to_send << temp
    #     end
    # end
    # render json: @array_to_send
=======
    group_members = GroupMember.where("user_id = ?", params[:id])
    array_to_send = Array.new

    group_members.each do |member|
        temp_id = member[:Group_id]
        temp = Hash.new
        group = Group.find_by_id(temp_id)
        if(group)
          temp["group_id"] = temp_id
          temp["group_name"] = group[:name]
          temp["user_id"] = group[:user_id]
          
          temp["members"] = GroupMember.where(:Group_id => temp_id)
          array_to_send << temp
        end
    end
    render json: array_to_send
>>>>>>> origin/master
   
    # respond_to do |format|
      
    #     format.html { redirect_to @array_to_send, notice: 'Groups were successfully found.' }
    #     format.json { render json: @array_to_send } 
    # end

  end

  # GET /users/1/publications

  def get_publications_for_user
   #start adding
   #groups_ids = User.find(params[:id]).group_members.select(:Group_id).map{|member| member.Group_id} #GroupMember.where(:user_id => params[:id]).select(:Group_id)
   #@publications_to_send = []
    
    publications_to_send = Array.new
    group_ids = Array.new
    user_id = params[:id]

    group_members = GroupMember.where("user_id = ?" , user_id)
    group_members.each do |member| 
      group_ids << member.Group_id
    end
    

    group_ids.each do |id|
       temp = Publication.where("audience = ? " , id)
        temp.each do |publication|
          publications_to_send << publication
        end
     end
     
    render json: publications_to_send
    end

#       temp.each do |publication|
#         publications_to_send << publication
#       end
#     end
#    render json: group_ids
#    end

    
#    if (group_ids)
#     group_ids.each do |group_id|
#       temp = Publication.where("audiance = ? " , group_id)
#       temp.each do |publication|
#         publications_to_send << publication
#       end
#     end
#   end
  
#  render json: publications_to_send  
#end
#end adding

       
    
#    if(groups_ids)
#      groups_ids.uniq!
#      groups_ids.each do |g|
#        temp = Publication.where("audience = ?",g)
#        @publications_to_send << temp
#      end
#    end
    
#    render json: @publications_to_send  
#  end


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
 
      #new user was created
      respond_to do |format|
        if @user.save 
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created}#, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
    
    # this user already exists
    if(op==1)
      respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to @user, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok}#, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end  
    end   
    rescue 
       render json: @user.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok}#, location: @user }
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
