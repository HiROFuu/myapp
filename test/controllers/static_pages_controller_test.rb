require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | 花乃國"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | 花乃國"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | 花乃國"    
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | 花乃國"
  end
  
  test "should get whats Ikebana" do
    get static_pages_whatsikebana_url
    assert_response :success
    assert_select "title", "Whats Ikebana | 花乃國"
  end

end
