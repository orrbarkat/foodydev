require 'spec_helper'

describe "registered_user_for_publications/index" do
  before(:each) do
    assign(:registered_user_for_publications, [
      stub_model(RegisteredUserForPublication,
        :publication_unique_id => 1,
        :device_uuid => "Device Uuid"
      ),
      stub_model(RegisteredUserForPublication,
        :publication_unique_id => 1,
        :device_uuid => "Device Uuid"
      )
    ])
  end

  it "renders a list of registered_user_for_publications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Device Uuid".to_s, :count => 2
  end
end
