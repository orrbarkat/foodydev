  class PublicationReportsController < ApplicationController
  before_action :set_publication_report, only: [:edit, :update, :destroy]

  def index
    if(params.has_key?(:publication_id) && params.has_key?(:publication_version))
     render json: PublicationReport.where( publication_id: params[:publication_id], publication_version: params[:publication_version] )
    else 
      render json: PublicationReport.all
    end
      
  end

  def create
    require ENV["push_path"]#ENV["push_path"]
    require ENV["gcm_path"]#ENV["gcm_path"]
    require 'houston'

    publication_report = PublicationReport.new(publication_report_params)
    publication_report.save!
    @publication = Publication.find(publication_report_params[:publication_id])
    render json:  publication_report
    pushReport(@publication, publication_report)
    pushGcmReports(@publication, publication_report)
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
    params.require(:publication_report).permit(:publication_id, :publication_version, :report, :date_of_report, :active_device_dev_uuid ,:report_user_name ,:report_contact_info)
  end
end
