require 'test_helper'

class EventimagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eventimage = eventimages(:one)
  end

  test "should get index" do
    get eventimages_url
    assert_response :success
  end

  test "should get new" do
    get new_eventimage_url
    assert_response :success
  end

  test "should create eventimage" do
    assert_difference('Eventimage.count') do
      post eventimages_url, params: { eventimage: {  } }
    end

    assert_redirected_to eventimage_url(Eventimage.last)
  end

  test "should show eventimage" do
    get eventimage_url(@eventimage)
    assert_response :success
  end

  test "should get edit" do
    get edit_eventimage_url(@eventimage)
    assert_response :success
  end

  test "should update eventimage" do
    patch eventimage_url(@eventimage), params: { eventimage: {  } }
    assert_redirected_to eventimage_url(@eventimage)
  end

  test "should destroy eventimage" do
    assert_difference('Eventimage.count', -1) do
      delete eventimage_url(@eventimage)
    end

    assert_redirected_to eventimages_url
  end
end
