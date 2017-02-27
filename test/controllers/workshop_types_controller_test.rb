require 'test_helper'

class WorkshopTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workshop_type = workshop_types(:one)
  end

  test "should get index" do
    get workshop_types_url
    assert_response :success
  end

  test "should get new" do
    get new_workshop_type_url
    assert_response :success
  end

  test "should create workshop_type" do
    assert_difference('WorkshopType.count') do
      post workshop_types_url, params: { workshop_type: { comment: @workshop_type.comment, type: @workshop_type.type } }
    end

    assert_redirected_to workshop_type_url(WorkshopType.last)
  end

  test "should show workshop_type" do
    get workshop_type_url(@workshop_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_workshop_type_url(@workshop_type)
    assert_response :success
  end

  test "should update workshop_type" do
    patch workshop_type_url(@workshop_type), params: { workshop_type: { comment: @workshop_type.comment, type: @workshop_type.type } }
    assert_redirected_to workshop_type_url(@workshop_type)
  end

  test "should destroy workshop_type" do
    assert_difference('WorkshopType.count', -1) do
      delete workshop_type_url(@workshop_type)
    end

    assert_redirected_to workshop_types_url
  end
end
