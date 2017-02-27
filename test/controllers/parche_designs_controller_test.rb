require 'test_helper'

class ParcheDesignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parche_design = parche_designs(:one)
  end

  test "should get index" do
    get parche_designs_url
    assert_response :success
  end

  test "should get new" do
    get new_parche_design_url
    assert_response :success
  end

  test "should create parche_design" do
    assert_difference('ParcheDesign.count') do
      post parche_designs_url, params: { parche_design: { cost: @parche_design.cost, details: @parche_design.details } }
    end

    assert_redirected_to parche_design_url(ParcheDesign.last)
  end

  test "should show parche_design" do
    get parche_design_url(@parche_design)
    assert_response :success
  end

  test "should get edit" do
    get edit_parche_design_url(@parche_design)
    assert_response :success
  end

  test "should update parche_design" do
    patch parche_design_url(@parche_design), params: { parche_design: { cost: @parche_design.cost, details: @parche_design.details } }
    assert_redirected_to parche_design_url(@parche_design)
  end

  test "should destroy parche_design" do
    assert_difference('ParcheDesign.count', -1) do
      delete parche_design_url(@parche_design)
    end

    assert_redirected_to parche_designs_url
  end
end
