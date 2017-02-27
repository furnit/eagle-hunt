require 'test_helper'

class AvailWorkshopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @avail_workshop = avail_workshops(:one)
  end

  test "should get index" do
    get avail_workshops_url
    assert_response :success
  end

  test "should get new" do
    get new_avail_workshop_url
    assert_response :success
  end

  test "should create avail_workshop" do
    assert_difference('AvailWorkshop.count') do
      post avail_workshops_url, params: { avail_workshop: { furniture_id: @avail_workshop.furniture_id, proposed_cost: @avail_workshop.proposed_cost, workshop_id: @avail_workshop.workshop_id } }
    end

    assert_redirected_to avail_workshop_url(AvailWorkshop.last)
  end

  test "should show avail_workshop" do
    get avail_workshop_url(@avail_workshop)
    assert_response :success
  end

  test "should get edit" do
    get edit_avail_workshop_url(@avail_workshop)
    assert_response :success
  end

  test "should update avail_workshop" do
    patch avail_workshop_url(@avail_workshop), params: { avail_workshop: { furniture_id: @avail_workshop.furniture_id, proposed_cost: @avail_workshop.proposed_cost, workshop_id: @avail_workshop.workshop_id } }
    assert_redirected_to avail_workshop_url(@avail_workshop)
  end

  test "should destroy avail_workshop" do
    assert_difference('AvailWorkshop.count', -1) do
      delete avail_workshop_url(@avail_workshop)
    end

    assert_redirected_to avail_workshops_url
  end
end
