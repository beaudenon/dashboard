require 'test_helper'

class SecubatModelsControllerTest < ActionController::TestCase
  setup do
    @secubat_model = secubat_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secubat_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secubat_model" do
    assert_difference('SecubatModel.count') do
      post :create, secubat_model: @secubat_model.attributes
    end

    assert_redirected_to secubat_model_path(assigns(:secubat_model))
  end

  test "should show secubat_model" do
    get :show, id: @secubat_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secubat_model.to_param
    assert_response :success
  end

  test "should update secubat_model" do
    put :update, id: @secubat_model.to_param, secubat_model: @secubat_model.attributes
    assert_redirected_to secubat_model_path(assigns(:secubat_model))
  end

  test "should destroy secubat_model" do
    assert_difference('SecubatModel.count', -1) do
      delete :destroy, id: @secubat_model.to_param
    end

    assert_redirected_to secubat_models_path
  end
end
