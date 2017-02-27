require 'test_helper'

class FurnitauresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @furnitaure = furnitaures(:one)
  end

  test "should get index" do
    get furnitaures_url
    assert_response :success
  end

  test "should get new" do
    get new_furnitaure_url
    assert_response :success
  end

  test "should create furnitaure" do
    assert_difference('Furnitaure.count') do
      post furnitaures_url, params: { furnitaure: { comment: @furnitaure.comment, furnitaure_detail_id: @furnitaure.furnitaure_detail_id, furnitaure_wage_id: @furnitaure.furnitaure_wage_id, name: @furnitaure.name } }
    end

    assert_redirected_to furnitaure_url(Furnitaure.last)
  end

  test "should show furnitaure" do
    get furnitaure_url(@furnitaure)
    assert_response :success
  end

  test "should get edit" do
    get edit_furnitaure_url(@furnitaure)
    assert_response :success
  end

  test "should update furnitaure" do
    patch furnitaure_url(@furnitaure), params: { furnitaure: { comment: @furnitaure.comment, furnitaure_detail_id: @furnitaure.furnitaure_detail_id, furnitaure_wage_id: @furnitaure.furnitaure_wage_id, name: @furnitaure.name } }
    assert_redirected_to furnitaure_url(@furnitaure)
  end

  test "should destroy furnitaure" do
    assert_difference('Furnitaure.count', -1) do
      delete furnitaure_url(@furnitaure)
    end

    assert_redirected_to furnitaures_url
  end
end
