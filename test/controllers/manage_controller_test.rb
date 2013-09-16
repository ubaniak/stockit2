require 'test_helper'

class ManageControllerTest < ActionController::TestCase
  test "should get accounts" do
    get :accounts
    assert_response :success
  end

  test "should get stocks" do
    get :stocks
    assert_response :success
  end

  test "should get account_transfer" do
    get :account_transfer
    assert_response :success
  end

  test "should get bills" do
    get :bills
    assert_response :success
  end

end
