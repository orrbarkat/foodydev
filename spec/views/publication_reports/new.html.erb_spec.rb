require 'spec_helper'

describe "publication_reports/new" do
  before(:each) do
    assign(:publication_report, stub_model(PublicationReport,
      :publication_unique_id => 1,
      :publication_version => 1,
      :report => 1,
      :reporting_device_uuid => "MyString"
    ).as_new_record)
  end

  it "renders new publication_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", publication_reports_path, "post" do
      assert_select "input#publication_report_publication_unique_id[name=?]", "publication_report[publication_unique_id]"
      assert_select "input#publication_report_publication_version[name=?]", "publication_report[publication_version]"
      assert_select "input#publication_report_report[name=?]", "publication_report[report]"
      assert_select "input#publication_report_reporting_device_uuid[name=?]", "publication_report[reporting_device_uuid]"
    end
  end
end
