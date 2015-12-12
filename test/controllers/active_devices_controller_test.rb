#require 'test_helper'

class ActiveDeviceControllerTest < ActionController::TestCase
  setup do
    @active_devices = active_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
   
  end

#   test "should get new" destroy
#     get :new
#     assert_response :success
#   end

#   test "should create publication" do
#     assert_difference('Publication.count') do
#       post :create, publication: { is_on_air: @publication.is_on_air, publication_address: @publication.publication_address, publication_contact_info: @publication.publication_contact_info, publication_ending_date: @publication.publication_ending_date, publication_latitude: @publication.publication_latitude, publication_longitude: @publication.publication_longitude, publication_starting_date: @publication.publication_starting_date, publication_title: @publication.publication_title, publication_type_of_collecting: @publication.publication_type_of_collecting, publication_version: @publication.publication_version, reporting_device_uuid: @publication.reporting_device_uuid }
#     end

#     assert_redirected_to publication_path(assigns(:publication))
#   end

#   test "should show publication" do
#     get :show, id: @publication
#     assert_response :success
#   end

#   test "should get edit" do
#     get :edit, id: @publication
#     assert_response :success
#   end

#   test "should update publication" do
#     patch :update, id: @publication, publication: { is_on_air: @publication.is_on_air, publication_address: @publication.publication_address, publication_contact_info: @publication.publication_contact_info, publication_ending_date: @publication.publication_ending_date, publication_latitude: @publication.publication_latitude, publication_longitude: @publication.publication_longitude, publication_starting_date: @publication.publication_starting_date, publication_title: @publication.publication_title, publication_type_of_collecting: @publication.publication_type_of_collecting, publication_version: @publication.publication_version, reporting_device_uuid: @publication.reporting_device_uuid }
#     assert_redirected_to publication_path(assigns(:publication))
#   end

#   test "should destroy publication" do
#     assert_difference('Publication.count', -1) do
#       delete :destroy, id: @publication
#     end

#     assert_redirected_to publications_path
#   end
end