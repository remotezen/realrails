require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:archer)
  end
  test "password resets" do
    
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, password_reset:{ email:"" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    
    post password_resets_path, password_reset: { 
      email: @user.email}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    user = assigns(:user)
    
    get edit_password_reset_path(user.reset_token, email:"")
    assert_redirected_to root_url
    
    user.toggle!(:activated)
    
    
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    

    get edit_password_reset_path(user.reset_token, email: user.email)
    assert :success
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    
    patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password: "foobaz", 
              password_confirmation: "grafunkel"}
      assert_select 'div#error_explanation'
    patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password: "", 
              password_confirmation: ""}
      assert_select 'div#error_explanation'
    
      patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password: "password", 
              password_confirmation: "password"}
      assert is_logged_in?
      assert_not flash.empty?
      assert_redirected_to user
  end
  test "expired token" do 
      get new_password_reset_path
      post password_resets_path password_reset: { email: @user.email }
      @user = assigns(:user)
      @user.update_attribute(:reset_sent_at, 3.hours.ago)
      patch password_reset_path(@user.reset_token),
          email: @user.email,
          user: { password:              "password",
                  password_confirmation: "password" }
          assert_response :redirect
          follow_redirect!
          assert_match /expired/i, response.body
          assert_match /Forgot password/i, response.body

  end
  

end
