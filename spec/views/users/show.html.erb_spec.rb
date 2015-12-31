require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identity Provider/)
    expect(rendered).to match(/Identity Provider User/)
    expect(rendered).to match(/Identity Provider Token/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Identity Provider Email/)
    expect(rendered).to match(/Identity Provider User Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Active Device Dev Uuid/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
