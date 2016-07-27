class Gcm
  require "net/https"
  require "uri"
  require 'json'

  AUTH = "key=AIzaSyAwyWkcnD_QEGBuhdzZMjrUgzm-oNw3GcA"

  attr_accessor :publication, :user_report, :registration

  class << self

    def group
      if ENV["S3_BUCKET"]=="foodcollectordev"
        return "/topics/dev"
      else
        return "/topics/prod"
      end
    end

  end

  def initialize(publication, report=nil, registration=nil)
    @publication=publication
    @user_report=report
    @registration=registration
  end

  def create
    if @publication.audience == 0
      devices = ActiveDevice.where(is_ios: false).where.not(remote_notification_token: "no").to_a.reverse
      devices.map!{|d| d.remote_notification_token} unless devices.empty?
    else
      devices = getTokens()
    end
    body = {:registration_ids => devices, :data => {:message => {
        :type => 'new_publication',
        :id => @publication.id,
        :version => @publication.version,
        :title => @publication.title,
        :latitude => @publication.latitude,
        :longitude => @publication.longitude
    }}}
    push(body) unless devices.empty?
  end

  def delete
    tokens = getTokens()
    body = {:registration_ids => tokens, :data => {:message => {
        :type => 'deleted_publication',
        id:@publication.id,
        version:@publication.version,
        title:@publication.title,
        latitude:@publication.latitude,
        longitude: @publication.longitude
    }}}
    push(body) unless tokens.empty?
  end

  def register
    tokens = getTokens
    tokens << owner
    body = {:registration_ids=>tokens, :data=>{ :message => {
        type: "registeration_for_publication",
        id:@publication.id,
        version: @publication.version,
        date:@registration.date_of_registration
    }}}
    push(body) unless tokens.empty?
  end

  def report
    tokens = getTokens()
    tokens << owner
    body = {:registration_ids => tokens, :data => {:message => {
        :type=>"publication_report",
        :publication_id=>@publication.id,
        :publication_version=>@publication.version,
        :date_of_report=>@user_report.date_of_report,
        :report=>@user_report.report
    }}}
    push(body) unless tokens.empty?
  end

  def new_member(id)
    tokens= getMembers(id)
    title = id ? 'public' : Group.find(id).name 
    body = { :registration_ids => tokens, :data => {:message => {
        :type => "group_members",
        :id => id,
        :title => title
    }}}
    push(body) unless tokens.empty?
  end


  private

  def getTokens()
    tokens = Array.new
    if @publication.audience == 0
      registered = @publication.registered_user_for_publication
      registered.each do |r|
        if r.is_real && !r.is_ios
          tokens << r.token
        end
      end
    else
      registered = GroupMember.where(Group_id: @publication.audience)
      registered.each do |r|
        r = r.token
        tokens << r.remote if (r.ios!=true && r.remote!= "no")
      end
    end
    tokens = tokens.uniq
    tokens.delete(ActiveDevice.find_by_dev_uuid(@registration.active_device_dev_uuid).remote_notification_token) unless @registration.nil?
    tokens.delete(ActiveDevice.find_by_dev_uuid(@user_report.active_device_dev_uuid).remote_notification_token) unless @user_report.nil?
    return tokens
  end

  def getMembers(group_id)
    registered = GroupMember.where(Group_id: group_id)
    tokens = []
    registered.each do |r|
      next if r.is_admin
      r = r.token
      tokens << r[:remote] if (r[:ios]!=true && r[:remote]!= "no")
    end
    return tokens
  end

  def owner()
    owner = ActiveDevice.find_by_dev_uuid(@publication.active_device_dev_uuid)
    return owner.remote_notification_token if (owner!=nil && owner.is_android)
  end


  def push(body)
    uri = URI.parse("https://android.googleapis.com/gcm/send")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    request["authorization"] = AUTH
    request["content-type"] = "application/json"
    request.body = body.to_json
    response = http.request(request)
    puts response
    puts response.code
  end

end
