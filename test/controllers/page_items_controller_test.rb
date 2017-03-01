require 'test_helper'

class PageItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_item = page_items(:one)
  end

  test "should get index" do
    get page_items_url
    assert_response :success
  end

  test "should get new" do
    get new_page_item_url
    assert_response :success
  end

  test "should create page_item" do
    assert_difference('PageItem.count') do
      post page_items_url, params: { page_item: { action: @page_item.action, controller: @page_item.controller, details: @page_item.details } }
    end

    assert_redirected_to page_item_url(PageItem.last)
  end

  test "should show page_item" do
    get page_item_url(@page_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_item_url(@page_item)
    assert_response :success
  end

  test "should update page_item" do
    patch page_item_url(@page_item), params: { page_item: { action: @page_item.action, controller: @page_item.controller, details: @page_item.details } }
    assert_redirected_to page_item_url(@page_item)
  end

  test "should destroy page_item" do
    assert_difference('PageItem.count', -1) do
      delete page_item_url(@page_item)
    end

    assert_redirected_to page_items_url
  end
end
