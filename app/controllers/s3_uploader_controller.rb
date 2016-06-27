class S3UploaderController < ApplicationController
  # before_action :set_publication

  def image
    file = params['file']
    image = MiniMagick::Image.new(file.tempfile.path)
    image.format "png"
    image.resize "100x100"
    pic = S3_BUCKET.object("#{params['id']}.#{params['version']}.jpg")
    pic.put(body: file)
    render json: "OK", status: :ok
  end

  def s3_access_token
    render json: {
      policy:    s3_upload_policy,
      signature: s3_upload_signature,
      key:       "#{s3_uploader_params['id']}.#{s3_uploader_params['version']}.jpg"#ENV['aws_key']
    } 
  end
protected

  def s3_upload_policy
    @policy ||= create_s3_upload_policy
  end

  def create_s3_upload_policy
    Base64.encode64(
      {
        "expiration" => 1.hour.from_now.utc.xmlschema,
        "conditions" => [
          { "bucket" =>  ENV['S3_BUCKET'] },
          [ "starts-with", "$key", "" ],
          { "acl" => "public-read" },
          [ "starts-with", "$Content-Type", "" ],
          [ "content-length-range", 0, 10 * 1024 * 1024 ]
        ]
      }.to_json).gsub(/\n/,'')
  end

  def s3_upload_signature
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), ENV['AWS_SECRET_ACCESS_KEY'], s3_upload_policy)).gsub("\n","")
  end

  def set_publication
    @publication = Publication.find(s3_uploader_params[:id])
  end

  def s3_uploader_params
    params.require(:s3).permit(:id, :version)
  end
end
