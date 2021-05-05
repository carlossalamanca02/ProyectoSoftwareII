require "test_helper"

class LoanControllerTest < ActionDispatch::IntegrationTest
  test "should get createLoan" do
    get loan_createLoan_url
    assert_response :success
  end

  test "should get searchLoan" do
    get loan_searchLoan_url
    assert_response :success
  end

  test "should get updateLoan" do
    get loan_updateLoan_url
    assert_response :success
  end

  test "should get deleteLoan" do
    get loan_deleteLoan_url
    assert_response :success
  end

  test "should get Inventary" do
    get loan_Inventary_url
    assert_response :success
  end
end
