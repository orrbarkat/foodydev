class GroupMembersController < ApplicationController
  before_action :set_group_member, only: [:show, :edit, :update, :destroy]
  before_action :group_member_params, only: [:create]

  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
  end

  # GET /group_members/new
  def new
    @group_member = GroupMember.new
  end

  # GET /group_members/1/edit
  def edit
  end

  # POST /group_members
  # POST /group_members.json
  def create
  
    members_params = params[:group_members]
    @send_group_members = Array.new
    
      members_params.each do |group_member|
        temp = GroupMember.new()
        temp.Group_id     = group_member[:Group_id]
        temp.is_admin     = group_member[:is_admin]
        temp.name         = group_member[:name]
        temp.phone_number = group_member[:phone_number]
        temp.user_id      = group_member[:user_id]
        if (temp.save)
          @send_group_members << temp
        else
          @send_group_members << "440"
        end
      end
      
      respond_to do |format|
      
        format.html { redirect_to @send_group_members, notice: 'Group members was successfully created.' }
        format.json { render json: @send_group_members } 
      end
  end

  # PATCH/PUT /group_members/1
  # PATCH/PUT /group_members/1.json
  def update
    respond_to do |format|
      if @group_member.update(group_member_params)
        format.html { redirect_to @group_member, notice: 'Group member was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_member }
      else
        format.html { render :edit }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    groupd_id = 0
    if (@group_member.is_admin)
      group_id = Group.find(@group_member.Group_id)
    end
    
    @group_member.destroy
    
    if(group_id > 0)
      @new_admin = GroupMember.find_by_Group_id(group_id)
      @new_admin.is_admin = true
      @new_admin.update!
      render json: @new_admin
    else
      render json: "OK"  
    end
    
    
    # respond_to do |format|
    #   format.html { redirect_to group_members_url, notice: 'Group member was successfully destroyed.' }
    #   format.json { head :no_content }
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_member
      @group_member = GroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_member_params
      params.permit(:group_members, array: [:Group_id, :user_id, :phone_number, :name, :is_admin])
    end
end