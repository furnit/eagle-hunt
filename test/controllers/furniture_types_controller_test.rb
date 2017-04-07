require 'test_helper'

class FurnitureTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @furniture_type = furniture_types(:one)
  end

  test "should get index" do
    get furniture_types_url
    assert_response :success
  end

  test "should get new" do
    get new_furniture_type_url
    assert_response :success
  end

  test "should create furniture_type" do
    assert_difference('FurnitureType.count') do
      post furniture_types_url, params: { furniture_type: { comment: @furniture_type.comment, type: @furniture_type.type } }
    end

    assert_redirected_to furniture_type_url(FurnitureType.last)
  end

  test "should show furniture_type" do
    get furniture_type_url(@furniture_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_furniture_type_url(@furniture_type)
    assert_response :success
  end

  test "should update furniture_type" do
    patch furniture_type_url(@furniture_type), params: { furniture_type: { comment: @furniture_type.comment, type: @furniture_type.type } }
    assert_redirected_to furniture_type_url(@furniture_type)
  end

  test "should destroy furniture_type" do
    assert_difference('FurnitureType.count', -1) do
      delete furniture_type_url(@furniture_type)
    end

    assert_redirected_to furniture_types_url
  end
end
