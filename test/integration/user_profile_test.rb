require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:archer)
  end
  test "profile display" do 
      get user_path(@user)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_select 'h1', text: @user.name
      assert_select 'h1>img'
      assert_match @user.microposts.count.to_s,response.body
      assert_select 'div.pagination'
      assert_select 'ul.pagination'
      end
end
