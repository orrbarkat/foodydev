require 'spec_helper'

describe "active_devices/index" do
  before(:each) do
    assign(:active_devices, [
      stub_model(ActiveDevice,
        :remote_notification_token => "Remote Notification Token",
        :is_ios => false,
        :last_location_latitude => "9.99",
        :last_location_longitude => "9.99",
        :device_uuid => "Device Uuid"
      ),
      stub_model(ActiveDevice,
        :remote_notification_token => "Remote Notification Token",
        :is_ios => false,
        :last_location_latitude => "9.99",
        :last_location_longitude => "9.99",
        :device_uuid => "Device Uuid"
      )
    ])
  end

  it "renders a list of active_devices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Remote Notification Token".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Device Uuid".to_s, :count => 2
  end
end
