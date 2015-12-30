require 'spec_helper'

describe "publication_reports/show" do
  before(:each) do
    @publication_report = assign(:publication_report, stub_model(PublicationReport,
      :publication_unique_id => 1,
      :publication_version => 2,
      :report => 3,
      :reporting_device_uuid => "Reporting Device Uuid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Reporting Device Uuid/)
  end
end
