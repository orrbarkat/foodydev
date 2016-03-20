# require 'rails_helper'

# RSpec.describe "feedbacks/index", type: :view do
#   before(:each) do
#     assign(:feedbacks, [
#       Feedback.create!(
#         :active_device_dev_uuid => "Active Device Dev Uuid",
#         :reporter_name => "Reporter Name",
#         :report => "Report"
#       ),
#       Feedback.create!(
#         :active_device_dev_uuid => "Active Device Dev Uuid",
#         :reporter_name => "Reporter Name",
#         :report => "Report"
#       )
#     ])
#   end

#   it "renders a list of feedbacks" do
#     render
#     assert_select "tr>td", :text => "Active Device Dev Uuid".to_s, :count => 2
#     assert_select "tr>td", :text => "Reporter Name".to_s, :count => 2
#     assert_select "tr>td", :text => "Report".to_s, :count => 2
#   end
# end
