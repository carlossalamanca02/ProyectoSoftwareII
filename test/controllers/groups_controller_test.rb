require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get indexGroups" do
    get groups_indexGroups_url
    assert_response :success
  end

  test "should get createGroups" do
    get groups_createGroups_url
    assert_response :success
  end

  test "should get searchGroups" do
    get groups_searchGroups_url
    assert_response :success
  end

  test "should get updateGroups" do
    get groups_updateGroups_url
    assert_response :success
  end

  test "should get deletegroups" do
    get groups_deletegroups_url
    assert_response :success
  end

  test "should get participants" do
    get groups_participants_url
    assert_response :success
  end
end
