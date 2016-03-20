# require 'rails_helper'

# RSpec.describe "users/edit", type: :view do
#   before(:each) do
#     @user = assign(:user, User.create!(
#       :identity_provider => "MyString",
#       :identity_provider_user_id => "MyString",
#       :identity_provider_token => "MyString",
#       :phone_number => "MyString",
#       :identity_provider_email => "MyString",
#       :identity_provider_user_name => "MyString",
#       :is_logged_in => false,
#       :active_device_dev_uuid => "MyString",
#       :ratings => "",
#       :cradits => "",
#       :foodies => ""
#     ))
#   end

#   it "renders the edit user form" do
#     render

#     assert_select "form[action=?][method=?]", user_path(@user), "post" do

#       assert_select "input#user_identity_provider[name=?]", "user[identity_provider]"

#       assert_select "input#user_identity_provider_user_id[name=?]", "user[identity_provider_user_id]"

#       assert_select "input#user_identity_provider_token[name=?]", "user[identity_provider_token]"

#       assert_select "input#user_phone_number[name=?]", "user[phone_number]"

#       assert_select "input#user_identity_provider_email[name=?]", "user[identity_provider_email]"

#       assert_select "input#user_identity_provider_user_name[name=?]", "user[identity_provider_user_name]"

#       assert_select "input#user_is_logged_in[name=?]", "user[is_logged_in]"

#       assert_select "input#user_active_device_dev_uuid[name=?]", "user[active_device_dev_uuid]"

#       assert_select "input#user_ratings[name=?]", "user[ratings]"

#       assert_select "input#user_cradits[name=?]", "user[cradits]"

#       assert_select "input#user_foodies[name=?]", "user[foodies]"
#     end
#   end
# end
