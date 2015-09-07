require 'test_helper'
#users controller test

class UsersControllerTest < ActionController::TestCase

def setup
  @user = users(:fred) 
  @other_user = users(:archer)
end

  test "should get new" do 
      get :new
      assert_response :success
  end


  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end


  test "should redirect index when not logged in" do 
      get :index
      assert_redirected_to login_url
  end
#users controller test
  test "should redirect destroy when not logged in" do 
    assert_no_difference 'User.count' do 
        delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
  
  test "should redirect when logged in as non admin" do 
      log_in_as(@other_user)
      assert_no_difference 'User.count' do 
          delete :destroy, id: @user
          

      end
      assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password: @other_user.password  ,
                                            password_confirmation:@other_user.password,
                                            admin: true }
    assert_not @other_user.admin?
  end
end
