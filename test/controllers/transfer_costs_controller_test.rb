require 'test_helper'

class TransferCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transfer_cost = transfer_costs(:one)
  end

  test "should get index" do
    get transfer_costs_url
    assert_response :success
  end

  test "should get new" do
    get new_transfer_cost_url
    assert_response :success
  end

  test "should create transfer_cost" do
    assert_difference('TransferCost.count') do
      post transfer_costs_url, params: { transfer_cost: { comment: @transfer_cost.comment, cost: @transfer_cost.cost, title: @transfer_cost.title } }
    end

    assert_redirected_to transfer_cost_url(TransferCost.last)
  end

  test "should show transfer_cost" do
    get transfer_cost_url(@transfer_cost)
    assert_response :success
  end

  test "should get edit" do
    get edit_transfer_cost_url(@transfer_cost)
    assert_response :success
  end

  test "should update transfer_cost" do
    patch transfer_cost_url(@transfer_cost), params: { transfer_cost: { comment: @transfer_cost.comment, cost: @transfer_cost.cost, title: @transfer_cost.title } }
    assert_redirected_to transfer_cost_url(@transfer_cost)
  end

  test "should destroy transfer_cost" do
    assert_difference('TransferCost.count', -1) do
      delete transfer_cost_url(@transfer_cost)
    end

    assert_redirected_to transfer_costs_url
  end
end
