class RegisteredUserForPublicationsController < ApplicationController
  before_action :set_registered_user_for_publication, only: [:show, :edit, :update, :destroy]

  # GET /registered_user_for_publications
  # GET /registered_user_for_publications.json
  def index
    @registered_user_for_publications = RegisteredUserForPublication.all
  end

  # GET /registered_user_for_publications/1
  # GET /registered_user_for_publications/1.json
  def show
  end

  # GET /registered_user_for_publications/new
  def new
    @registered_user_for_publication = RegisteredUserForPublication.new
  end

  # GET /registered_user_for_publications/1/edit
  def edit
  end

  # POST /registered_user_for_publications
  # POST /registered_user_for_publications.json
  def create
    @registered_user_for_publication = RegisteredUserForPublication.new(registered_user_for_publication_params)

    respond_to do |format|
      if @registered_user_for_publication.save
        format.html { redirect_to @registered_user_for_publication, notice: 'Registered user for publication was successfully created.' }
        format.json { render :show, status: :created, location: @registered_user_for_publication }
      else
        format.html { render :new }
        format.json { render json: @registered_user_for_publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registered_user_for_publications/1
  # PATCH/PUT /registered_user_for_publications/1.json
  def update
    respond_to do |format|
      if @registered_user_for_publication.update(registered_user_for_publication_params)
        format.html { redirect_to @registered_user_for_publication, notice: 'Registered user for publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @registered_user_for_publication }
      else
        format.html { render :edit }
        format.json { render json: @registered_user_for_publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registered_user_for_publications/1
  # DELETE /registered_user_for_publications/1.json
  def destroy
    @registered_user_for_publication.destroy
    respond_to do |format|
      format.html { redirect_to registered_user_for_publications_url, notice: 'Registered user for publication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registered_user_for_publication
      @registered_user_for_publication = RegisteredUserForPublication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registered_user_for_publication_params
      params.require(:registered_user_for_publication).permit(:publication_unique_id, :date_of_registration, :device_uuid)
    end
end
