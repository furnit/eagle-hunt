require 'test_helper'

class FurnitureWagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @furniture_wage = furniture_wages(:one)
  end

  test "should get index" do
    get furniture_wages_url
    assert_response :success
  end

  test "should get new" do
    get new_furniture_wage_url
    assert_response :success
  end

  test "should create furniture_wage" do
    assert_difference('FurnitureWage.count') do
      post furniture_wages_url, params: { furniture_wage: { comment: @furniture_wage.comment, extra: @furniture_wage.extra, khayat: @furniture_wage.khayat, naghash: @furniture_wage.naghash, naja: @furniture_wage.naja, rokob: @furniture_wage.rokob } }
    end

    assert_redirected_to furniture_wage_url(FurnitureWage.last)
  end

  test "should show furniture_wage" do
    get furniture_wage_url(@furniture_wage)
    assert_response :success
  end

  test "should get edit" do
    get edit_furniture_wage_url(@furniture_wage)
    assert_response :success
  end

  test "should update furniture_wage" do
    patch furniture_wage_url(@furniture_wage), params: { furniture_wage: { comment: @furniture_wage.comment, extra: @furniture_wage.extra, khayat: @furniture_wage.khayat, naghash: @furniture_wage.naghash, naja: @furniture_wage.naja, rokob: @furniture_wage.rokob } }
    assert_redirected_to furniture_wage_url(@furniture_wage)
  end

  test "should destroy furniture_wage" do
    assert_difference('FurnitureWage.count', -1) do
      delete furniture_wage_url(@furniture_wage)
    end

    assert_redirected_to furniture_wages_url
  end
end
