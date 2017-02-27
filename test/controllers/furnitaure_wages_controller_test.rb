require 'test_helper'

class FurnitaureWagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @furnitaure_wage = furnitaure_wages(:one)
  end

  test "should get index" do
    get furnitaure_wages_url
    assert_response :success
  end

  test "should get new" do
    get new_furnitaure_wage_url
    assert_response :success
  end

  test "should create furnitaure_wage" do
    assert_difference('FurnitaureWage.count') do
      post furnitaure_wages_url, params: { furnitaure_wage: { comment: @furnitaure_wage.comment, extra: @furnitaure_wage.extra, khayat: @furnitaure_wage.khayat, naghash: @furnitaure_wage.naghash, naja: @furnitaure_wage.naja, rokob: @furnitaure_wage.rokob } }
    end

    assert_redirected_to furnitaure_wage_url(FurnitaureWage.last)
  end

  test "should show furnitaure_wage" do
    get furnitaure_wage_url(@furnitaure_wage)
    assert_response :success
  end

  test "should get edit" do
    get edit_furnitaure_wage_url(@furnitaure_wage)
    assert_response :success
  end

  test "should update furnitaure_wage" do
    patch furnitaure_wage_url(@furnitaure_wage), params: { furnitaure_wage: { comment: @furnitaure_wage.comment, extra: @furnitaure_wage.extra, khayat: @furnitaure_wage.khayat, naghash: @furnitaure_wage.naghash, naja: @furnitaure_wage.naja, rokob: @furnitaure_wage.rokob } }
    assert_redirected_to furnitaure_wage_url(@furnitaure_wage)
  end

  test "should destroy furnitaure_wage" do
    assert_difference('FurnitaureWage.count', -1) do
      delete furnitaure_wage_url(@furnitaure_wage)
    end

    assert_redirected_to furnitaure_wages_url
  end
end
