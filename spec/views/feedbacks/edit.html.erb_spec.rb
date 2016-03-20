# require 'rails_helper'

# RSpec.describe "feedbacks/edit", type: :view do
#   before(:each) do
#     @feedback = assign(:feedback, Feedback.create!(
#       :active_device_dev_uuid => "MyString",
#       :reporter_name => "MyString",
#       :report => "MyString"
#     ))
#   end

#   it "renders the edit feedback form" do
#     render

#     assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do

#       assert_select "input#feedback_active_device_dev_uuid[name=?]", "feedback[active_device_dev_uuid]"

#       assert_select "input#feedback_reporter_name[name=?]", "feedback[reporter_name]"

#       assert_select "input#feedback_report[name=?]", "feedback[report]"
#     end
#   end
# end
