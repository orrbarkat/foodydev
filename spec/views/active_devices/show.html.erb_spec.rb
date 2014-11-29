require 'spec_helper'

describe "active_devices/show" do
  before(:each) do
    @active_device = assign(:active_device, stub_model(ActiveDevice,
      :remote_notification_token => "Remote Notification Token",
      :is_ios => false,
      :last_location_latitude => "9.99",
      :last_location_longitude => "9.99",
      :device_uuid => "Device Uuid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Remote Notification Token/)
    rendered.should match(/false/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/Device Uuid/)
  end
end
