#require 'test_helper'

class PublicationsControllerTest < ActionController::TestCase
  setup do
    @publication = publications(:one)
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_not_nil assigns(:publications)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should create publication" do
    assert_difference('Publication.count') do
      post :create, publication: { is_on_air: @publication.is_on_air, address: @publication.address, contact_info: @publication.contact_info, ending_date: @publication.ending_date, latitude: @publication.latitude, longitude: @publication.longitude, starting_date: @publication.starting_date, title: @publication.title, type_of_collecting: @publication.type_of_collecting, version: @publication.version, active_device_dev_uuid: @publication.active_device_dev_uuid }
    end

  #   assert_redirected_to publication_path(assigns(:publication))
  end

   test "should show publication" do
     get :show, id: @publication
     assert_response :success
   end

  # test "should get edit" do
  #    get :edit, id: @publication
  #    assert_response :success
  #  end

  test "should update publication" do
    patch :update, id: @publication, publication: { is_on_air: @publication.is_on_air, address: @publication.address, contact_info: @publication.contact_info, ending_date: @publication.ending_date, latitude: @publication.latitude, longitude: @publication.longitude, starting_date: @publication.starting_date, title: "update", type_of_collecting: @publication.type_of_collecting, version: @publication.version, active_device_dev_uuid: @publication.active_device_dev_uuid }
    
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete :destroy, id: @publication, publication: { is_on_air: @publication.is_on_air, address: @publication.address, contact_info: @publication.contact_info, ending_date: @publication.ending_date, latitude: @publication.latitude, longitude: @publication.longitude, starting_date: @publication.starting_date, title: "update", type_of_collecting: @publication.type_of_collecting, version: @publication.version, active_device_dev_uuid: @publication.active_device_dev_uuid }
    end

   #assert_redirected_to publication_path(assigns(:publication))
  end
end