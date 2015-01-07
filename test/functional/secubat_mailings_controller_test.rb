require 'test_helper'

class SecubatMailingsControllerTest < ActionController::TestCase
  setup do
    @secubat_mailing = secubat_mailings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secubat_mailings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create secubat_mailing" do
    assert_difference('SecubatMailing.count') do
      post :create, secubat_mailer: @secubat_mailing.attributes
    end

    assert_redirected_to secubat_mailing_path(assigns(:secubat_mailer))
  end

  test "should show secubat_mailing" do
    get :show, id: @secubat_mailing.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @secubat_mailing.to_param
    assert_response :success
  end

  test "should update secubat_mailing" do
    put :update, id: @secubat_mailing.to_param, secubat_mailer: @secubat_mailing.attributes
    assert_redirected_to secubat_mailing_path(assigns(:secubat_mailer))
  end

  test "should destroy secubat_mailing" do
    assert_difference('SecubatMailing.count', -1) do
      delete :destroy, id: @secubat_mailing.to_param
    end

    assert_redirected_to secubat_mailings_path
  end
end
