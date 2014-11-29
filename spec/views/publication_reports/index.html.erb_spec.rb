require 'spec_helper'

describe "publication_reports/index" do
  before(:each) do
    assign(:publication_reports, [
      stub_model(PublicationReport,
        :publication_unique_id => 1,
        :publication_version => 2,
        :report => 3,
        :reporting_device_uuid => "Reporting Device Uuid"
      ),
      stub_model(PublicationReport,
        :publication_unique_id => 1,
        :publication_version => 2,
        :report => 3,
        :reporting_device_uuid => "Reporting Device Uuid"
      )
    ])
  end

  it "renders a list of publication_reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Reporting Device Uuid".to_s, :count => 2
  end
end
