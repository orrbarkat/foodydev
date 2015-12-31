require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :identity_provider => "Identity Provider",
        :identity_provider_user_id => "Identity Provider User",
        :identity_provider_token => "Identity Provider Token",
        :phone_number => "Phone Number",
        :identity_provider_email => "Identity Provider Email",
        :identity_provider_user_name => "Identity Provider User Name",
        :is_logged_in => false,
        :active_device_dev_uuid => "Active Device Dev Uuid",
        :ratings => "",
        :cradits => "",
        :foodies => ""
      ),
      User.create!(
        :identity_provider => "Identity Provider",
        :identity_provider_user_id => "Identity Provider User",
        :identity_provider_token => "Identity Provider Token",
        :phone_number => "Phone Number",
        :identity_provider_email => "Identity Provider Email",
        :identity_provider_user_name => "Identity Provider User Name",
        :is_logged_in => false,
        :active_device_dev_uuid => "Active Device Dev Uuid",
        :ratings => "",
        :cradits => "",
        :foodies => ""
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Identity Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Identity Provider User".to_s, :count => 2
    assert_select "tr>td", :text => "Identity Provider Token".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Identity Provider Email".to_s, :count => 2
    assert_select "tr>td", :text => "Identity Provider User Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Active Device Dev Uuid".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
