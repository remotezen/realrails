require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "Real Rails Application"
  end
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title }"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title }"
  end
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{ @base_title }"
  end
  test "should get contact" do
    get :contact
    assert_response :success 
    assert_select "title", "Contact | #{ @base_title }"

  end
  test "should have text area input" do 
    @user = users(:archer)
    log_in_as(@user)
    assert_select 'textarea'
    post microposts_path, micropost: { content: content }
    assert_equal @user.microposts.count, 1
    post microposts_path, micropost: { content: content }
    assert_equal @user.microposts.count, 2 
    assert_match "2 microposts", response.body

      
  end
end
