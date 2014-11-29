require 'spec_helper'

describe "registered_user_for_publications/show" do
  before(:each) do
    @registered_user_for_publication = assign(:registered_user_for_publication, stub_model(RegisteredUserForPublication,
      :publication_unique_id => 1,
      :device_uuid => "Device Uuid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Device Uuid/)
  end
end
