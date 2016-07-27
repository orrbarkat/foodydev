class Push
	require_relative('./apn.rb')
  require_relative('./gcm.rb')

	attr_accessor :apn, :gcm, :publication, :user_report, :registration

	def initialize(publication=nil, report=nil, registration=nil, params = {})
		@publication = publication
		@user_report=report
    @registration=registration
    @params = params
    @apn = Apn.new(@publication,report,@registration)
    @gcm = Gcm.new(@publication,report,@registration)
  end

  def create
    Rails.logger.warn "gcm now pushing"
    @gcm.create
    Rails.logger.warn "apn now pushing"
    @apn.create
  end

  def delete
    @gcm.delete
    @apn.delete
  end

  def register
    @gcm.register
    puts "finished Gcm"
    @apn.register
  end

  def report
    @gcm.report
    @apn.report
  end

  def new_member
    return false unless @params[:group_id]
    @gcm.new_member(@params[:group_id])
    @apn.new_member(@params[:group_id])
  end

  def remove_member
    return false unless @params[:group_id]
    @gcm.new_member(@params[:group_id])
    @apn.remove_member(@params[:group_id])
  end

end






