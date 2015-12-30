require 'spec_helper'

describe "registered_user_for_publications/edit" do
  before(:each) do
    @registered_user_for_publication = assign(:registered_user_for_publication, stub_model(RegisteredUserForPublication,
      :publication_unique_id => 1,
      :device_uuid => "MyString"
    ))
  end

  it "renders the edit registered_user_for_publication form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", registered_user_for_publication_path(@registered_user_for_publication), "post" do
      assert_select "input#registered_user_for_publication_publication_unique_id[name=?]", "registered_user_for_publication[publication_unique_id]"
      assert_select "input#registered_user_for_publication_device_uuid[name=?]", "registered_user_for_publication[device_uuid]"
    end
  end
end
