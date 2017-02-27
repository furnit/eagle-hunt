require 'test_helper'

class CostFactorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cost_factor = cost_factors(:one)
  end

  test "should get index" do
    get cost_factors_url
    assert_response :success
  end

  test "should get new" do
    get new_cost_factor_url
    assert_response :success
  end

  test "should create cost_factor" do
    assert_difference('CostFactor.count') do
      post cost_factors_url, params: { cost_factor: { extras: @cost_factor.extras, kande_colours: @cost_factor.kande_colours, kande_design: @cost_factor.kande_design, parche_colour: @cost_factor.parche_colour, parche_design: @cost_factor.parche_design, profit_percentage: @cost_factor.profit_percentage, size_abr: @cost_factor.size_abr, size_kanaf: @cost_factor.size_kanaf, size_parche: @cost_factor.size_parche, transfer_cost: @cost_factor.transfer_cost, wage_khayat: @cost_factor.wage_khayat, wage_naghash: @cost_factor.wage_naghash, wage_najar: @cost_factor.wage_najar, wage_rokob: @cost_factor.wage_rokob } }
    end

    assert_redirected_to cost_factor_url(CostFactor.last)
  end

  test "should show cost_factor" do
    get cost_factor_url(@cost_factor)
    assert_response :success
  end

  test "should get edit" do
    get edit_cost_factor_url(@cost_factor)
    assert_response :success
  end

  test "should update cost_factor" do
    patch cost_factor_url(@cost_factor), params: { cost_factor: { extras: @cost_factor.extras, kande_colours: @cost_factor.kande_colours, kande_design: @cost_factor.kande_design, parche_colour: @cost_factor.parche_colour, parche_design: @cost_factor.parche_design, profit_percentage: @cost_factor.profit_percentage, size_abr: @cost_factor.size_abr, size_kanaf: @cost_factor.size_kanaf, size_parche: @cost_factor.size_parche, transfer_cost: @cost_factor.transfer_cost, wage_khayat: @cost_factor.wage_khayat, wage_naghash: @cost_factor.wage_naghash, wage_najar: @cost_factor.wage_najar, wage_rokob: @cost_factor.wage_rokob } }
    assert_redirected_to cost_factor_url(@cost_factor)
  end

  test "should destroy cost_factor" do
    assert_difference('CostFactor.count', -1) do
      delete cost_factor_url(@cost_factor)
    end

    assert_redirected_to cost_factors_url
  end
end
