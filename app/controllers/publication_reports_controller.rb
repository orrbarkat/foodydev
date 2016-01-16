  class PublicationReportsController < ApplicationController
  before_action :set_publication_report, only: [:edit, :update, :destroy]
  after_action :pushReport, only: [:create]

  def index
    if(params.has_key?(:publication_id) && params.has_key?(:publication_version))
     render json: PublicationReport.where( publication_id: params[:publication_id], publication_version: params[:publication_version] )
    else 
      render json: PublicationReport.all
    end
      
  end

  def create
    @report = PublicationReport.new(publication_report_params)
    @report.save!
    @publication = Publication.find(publication_report_params[:publication_id])
    render json:  @report
  rescue
    render json: @report.errors, status: :unprocessable_entity 
  end

private
  
  def pushReport
    require ENV["push_path"]
    puts @publication.id
    push = Push.new(publication=>@publication,report=>@report)
    push.report
  rescue => e
    logger.warn "Unable to push, will ignore: #{e}"
  end

    # Use callbacks to share common setup or constraints between actions.
  def set_publication_report
    @publication_report = PublicationReport.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publication_report_params
    params.require(:publication_report).permit(:publication_id, :publication_version, :report, :date_of_report, :active_device_dev_uuid ,:report_user_name ,:report_contact_info)
  end
end
