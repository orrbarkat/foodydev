  class PublicationReportsController < ApplicationController
  before_action :set_publication_report, only: [:edit, :update, :destroy]

  def index
    render json: PublicationReport.where( publication_id: params[:publication_id], publication_version: params[:publication_version] )
  end

  def create
    publication_report = PublicationReport.new(publication_report_params)
    publication_report.save!
    render json:  publication_report
  rescue
    render json: publication_report.errors, status: :unprocessable_entity 
  end

private
    # Use callbacks to share common setup or constraints between actions.
  def set_publication_report
    @publication_report = PublicationReport.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publication_report_params
    params.require(:publication_report).permit(:publication_id, :publication_version, :report, :date_of_report, :active_device_dev_uuid)
  end
end
