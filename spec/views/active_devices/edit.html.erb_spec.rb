require 'spec_helper'

describe "active_devices/edit" do
  before(:each) do
    @active_device = assign(:active_device, stub_model(ActiveDevice,
      :remote_notification_token => "MyString",
      :is_ios => false,
      :last_location_latitude => "9.99",
      :last_location_longitude => "9.99",
      :device_uuid => "MyString"
    ))
  end

  it "renders the edit active_device form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", active_device_path(@active_device), "post" do
      assert_select "input#active_device_remote_notification_token[name=?]", "active_device[remote_notification_token]"
      assert_select "input#active_device_is_ios[name=?]", "active_device[is_ios]"
      assert_select "input#active_device_last_location_latitude[name=?]", "active_device[last_location_latitude]"
      assert_select "input#active_device_last_location_longitude[name=?]", "active_device[last_location_longitude]"
      assert_select "input#active_device_device_uuid[name=?]", "active_device[device_uuid]"
    end
  end
end
