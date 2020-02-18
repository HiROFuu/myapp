require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "花乃國"
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "花乃國"
  end

  test "should get help" do
    get help_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end
  
  test "should get whats Ikebana" do
    get whatsikebana_path
    assert_response :success
  end

end
