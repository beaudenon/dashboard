require 'test_helper'

class SecubatClientsControllerTest < ActionController::TestCase
  setup do
    @secubat_client = secubat_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secubat_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secubat_client" do
    assert_difference('SecubatClient.count') do
      post :create, secubat_client: @secubat_client.attributes
    end

    assert_redirected_to secubat_client_path(assigns(:secubat_client))
  end

  test "should show secubat_client" do
    get :show, id: @secubat_client.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secubat_client.to_param
    assert_response :success
  end

  test "should update secubat_client" do
    put :update, id: @secubat_client.to_param, secubat_client: @secubat_client.attributes
    assert_redirected_to secubat_client_path(assigns(:secubat_client))
  end

  test "should destroy secubat_client" do
    assert_difference('SecubatClient.count', -1) do
      delete :destroy, id: @secubat_client.to_param
    end

    assert_redirected_to secubat_clients_path
  end
end
