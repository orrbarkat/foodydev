class PublicationReportsController < ApplicationController
  before_action :set_publication_report, only: [:show, :edit, :update, :destroy]

  # GET /publication_reports
  # GET /publication_reports.json
  def index
    @publication_reports = PublicationReport.all
  end

  # GET /publication_reports/1
  # GET /publication_reports/1.json
  def show
  end

  # GET /publication_reports/new
  def new
    @publication_report = PublicationReport.new
  end

  # GET /publication_reports/1/edit
  def edit
  end

  # POST /publication_reports
  # POST /publication_reports.json
  def create
    @publication_report = PublicationReport.new(publication_report_params)

    respond_to do |format|
      if @publication_report.save
        format.html { redirect_to @publication_report, notice: 'Publication report was successfully created.' }
        format.json { render :show, status: :created, location: @publication_report }
      else
        format.html { render :new }
        format.json { render json: @publication_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publication_reports/1
  # PATCH/PUT /publication_reports/1.json
  def update
    respond_to do |format|
      if @publication_report.update(publication_report_params)
        format.html { redirect_to @publication_report, notice: 'Publication report was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication_report }
      else
        format.html { render :edit }
        format.json { render json: @publication_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publication_reports/1
  # DELETE /publication_reports/1.json
  def destroy
    @publication_report.destroy
    respond_to do |format|
      format.html { redirect_to publication_reports_url, notice: 'Publication report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication_report
      @publication_report = PublicationReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_report_params
      params.require(:publication_report).permit(:publication_unique_id, :publication_version, :report, :date_of_report, :reporting_device_uuid)
    end
end
