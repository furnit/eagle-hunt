require 'test_helper'

class ParcheColoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parche_colour = parche_colours(:one)
  end

  test "should get index" do
    get parche_colours_url
    assert_response :success
  end

  test "should get new" do
    get new_parche_colour_url
    assert_response :success
  end

  test "should create parche_colour" do
    assert_difference('ParcheColour.count') do
      post parche_colours_url, params: { parche_colour: { cost: @parche_colour.cost, details: @parche_colour.details } }
    end

    assert_redirected_to parche_colour_url(ParcheColour.last)
  end

  test "should show parche_colour" do
    get parche_colour_url(@parche_colour)
    assert_response :success
  end

  test "should get edit" do
    get edit_parche_colour_url(@parche_colour)
    assert_response :success
  end

  test "should update parche_colour" do
    patch parche_colour_url(@parche_colour), params: { parche_colour: { cost: @parche_colour.cost, details: @parche_colour.details } }
    assert_redirected_to parche_colour_url(@parche_colour)
  end

  test "should destroy parche_colour" do
    assert_difference('ParcheColour.count', -1) do
      delete parche_colour_url(@parche_colour)
    end

    assert_redirected_to parche_colours_url
  end
end
