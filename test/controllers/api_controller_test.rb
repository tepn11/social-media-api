require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get addUser" do
    post api_addUser_url
    assert_response :success
  end

  test "should get addFriend" do
    post api_addFriend_url
    assert_response :success
  end

  test "should get getFriends" do
    post api_getFriends_url
    assert_response :success
  end

  test "should get getCommonFriends" do
    post api_getCommonFriends_url
    assert_response :success
  end

  test "should get subsribe" do
    post api_subsribe_url
    assert_response :success
  end

  test "should get block" do
    post api_block_url
    assert_response :success
  end

  test "should get getUsersForUpdate" do
    post api_getUsersForUpdate_url
    assert_response :success
  end

end
