require 'spec_helper'

describe "ActiveDevices" do
  describe "GET /active_devices" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get active_devices_path
      response.status.should be(200)
    end
  end
end
