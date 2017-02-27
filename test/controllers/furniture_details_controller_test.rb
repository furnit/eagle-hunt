require 'test_helper'

class FurnitureDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @furniture_detail = furniture_details(:one)
  end

  test "should get index" do
    get furniture_details_url
    assert_response :success
  end

  test "should get new" do
    get new_furniture_detail_url
    assert_response :success
  end

  test "should create furniture_detail" do
    assert_difference('FurnitureDetail.count') do
      post furniture_details_url, params: { furniture_detail: { available: @furniture_detail.available, images: @furniture_detail.images, size_abr: @furniture_detail.size_abr, size_kanaf: @furniture_detail.size_kanaf, size_parche: @furniture_detail.size_parche } }
    end

    assert_redirected_to furniture_detail_url(FurnitureDetail.last)
  end

  test "should show furniture_detail" do
    get furniture_detail_url(@furniture_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_furniture_detail_url(@furniture_detail)
    assert_response :success
  end

  test "should update furniture_detail" do
    patch furniture_detail_url(@furniture_detail), params: { furniture_detail: { available: @furniture_detail.available, images: @furniture_detail.images, size_abr: @furniture_detail.size_abr, size_kanaf: @furniture_detail.size_kanaf, size_parche: @furniture_detail.size_parche } }
    assert_redirected_to furniture_detail_url(@furniture_detail)
  end

  test "should destroy furniture_detail" do
    assert_difference('FurnitureDetail.count', -1) do
      delete furniture_detail_url(@furniture_detail)
    end

    assert_redirected_to furniture_details_url
  end
end
