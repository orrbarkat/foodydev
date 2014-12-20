class PublicationReportsController < ApplicationController
  before_action :set_publication_report, only: [:show, :edit, :update, :destroy]

  # GET /publication_reports
  # GET /publication_reports.json
  def index
   render json: PublicationReport.all
  end


  def create
    publication_report = PublicationReport.create!(publication_report_params)
    render json: publication_report
  rescue
    render json: publication_report.errors, status: :unprocessable_entity 
  end

  # PATCH/PUT /publication_reports/1
  # PATCH/PUT /publication_reports/1.json
  def update
    publication_report = Publication_report.update!(publication_report_params)
    render json publication_report 
  rescue
    render json: @publication_report.errors, status: :unprocessable_entity 
  end

  # DELETE /publication_reports/1
  # DELETE /publication_reports/1.json
  def destroy
    @publication_report.destroy
    render json: "OK"
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
