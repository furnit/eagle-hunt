require 'test_helper'

class KandeColoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kande_colour = kande_colours(:one)
  end

  test "should get index" do
    get kande_colours_url
    assert_response :success
  end

  test "should get new" do
    get new_kande_colour_url
    assert_response :success
  end

  test "should create kande_colour" do
    assert_difference('KandeColour.count') do
      post kande_colours_url, params: { kande_colour: { cost: @kande_colour.cost, details: @kande_colour.details } }
    end

    assert_redirected_to kande_colour_url(KandeColour.last)
  end

  test "should show kande_colour" do
    get kande_colour_url(@kande_colour)
    assert_response :success
  end

  test "should get edit" do
    get edit_kande_colour_url(@kande_colour)
    assert_response :success
  end

  test "should update kande_colour" do
    patch kande_colour_url(@kande_colour), params: { kande_colour: { cost: @kande_colour.cost, details: @kande_colour.details } }
    assert_redirected_to kande_colour_url(@kande_colour)
  end

  test "should destroy kande_colour" do
    assert_difference('KandeColour.count', -1) do
      delete kande_colour_url(@kande_colour)
    end

    assert_redirected_to kande_colours_url
  end
end
