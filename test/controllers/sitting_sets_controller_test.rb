require 'test_helper'

class SittingSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sitting_set = sitting_sets(:one)
  end

  test "should get index" do
    get sitting_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_sitting_set_url
    assert_response :success
  end

  test "should create sitting_set" do
    assert_difference('SittingSet.count') do
      post sitting_sets_url, params: { sitting_set: { comment: @sitting_set.comment, count: @sitting_set.count, details: @sitting_set.details } }
    end

    assert_redirected_to sitting_set_url(SittingSet.last)
  end

  test "should show sitting_set" do
    get sitting_set_url(@sitting_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_sitting_set_url(@sitting_set)
    assert_response :success
  end

  test "should update sitting_set" do
    patch sitting_set_url(@sitting_set), params: { sitting_set: { comment: @sitting_set.comment, count: @sitting_set.count, details: @sitting_set.details } }
    assert_redirected_to sitting_set_url(@sitting_set)
  end

  test "should destroy sitting_set" do
    assert_difference('SittingSet.count', -1) do
      delete sitting_set_url(@sitting_set)
    end

    assert_redirected_to sitting_sets_url
  end
end
