require 'test_helper'

class OrderdetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orderdetail = orderdetails(:one)
  end

  test "should get index" do
    get orderdetails_url
    assert_response :success
  end

  test "should get new" do
    get new_orderdetail_url
    assert_response :success
  end

  test "should create orderdetail" do
    assert_difference('Orderdetail.count') do
      post orderdetails_url, params: { orderdetail: {  } }
    end

    assert_redirected_to orderdetail_url(Orderdetail.last)
  end

  test "should show orderdetail" do
    get orderdetail_url(@orderdetail)
    assert_response :success
  end

  test "should get edit" do
    get edit_orderdetail_url(@orderdetail)
    assert_response :success
  end

  test "should update orderdetail" do
    patch orderdetail_url(@orderdetail), params: { orderdetail: {  } }
    assert_redirected_to orderdetail_url(@orderdetail)
  end

  test "should destroy orderdetail" do
    assert_difference('Orderdetail.count', -1) do
      delete orderdetail_url(@orderdetail)
    end

    assert_redirected_to orderdetails_url
  end
end
