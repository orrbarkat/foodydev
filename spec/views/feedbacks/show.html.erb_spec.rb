require 'rails_helper'

RSpec.describe "feedbacks/show", type: :view do
  before(:each) do
    @feedback = assign(:feedback, Feedback.create!(
      :active_device_dev_uuid => "Active Device Dev Uuid",
      :reporter_name => "Reporter Name",
      :report => "Report"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Active Device Dev Uuid/)
    expect(rendered).to match(/Reporter Name/)
    expect(rendered).to match(/Report/)
  end
end
