class GroupMembersController < ApplicationController
  before_action :set_group_member, only: [:show, :edit, :update, :destroy]
  before_action :group_member_params

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
  
    members = (group_member_params).collect {|key, group_member_values| GroupMember.new(group_member_values)}
    
    all_members_valid = true
    members.each_with_index do |member|
        unless member.valid?
            all_members_valid = false
        end
    end
    
    @send_group_members = []
    
    if (all_members_valid)
    
      members.each do |group_member|
        group_member.save
        @send_group_members << group_member
      end
      
      format.html { redirect_to @send_group_members, notice: 'Group members was successfully created.' }
      format.json { render :show, status: :created, location: @send_group_members } 
    
    else
      format.html { render :new }
      format.json { render json: @group_member.errors, status: :unprocessable_entity }
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
    @group_member.destroy
    respond_to do |format|
      format.html { redirect_to group_members_url, notice: 'Group member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_member
      @group_member = GroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_member_params
      params[:group_member]
    end
end
