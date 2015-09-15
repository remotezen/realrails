require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:archer)
  end
  test 'micropost interface' do 
      log_in_as(@user)
      get root_path
      assert_select 'div.pagination'
      assert_no_difference 'Micropost.count' do 
          post microposts_path, micropost:{ content: "" }

      end
      assert_select 'div#error_explanation'
      content = "this micropost really ties the room together"
      picture = fixture_file_upload('test/fixtures/DSC_1815.JPG')
      
      assert_difference 'Micropost.count' ,1 do 
        post microposts_path, micropost: { content: content, 
                                           picture: picture }
        assert_not @user.microposts.first.picture.nil?
      end
      assert_redirected_to root_url
      follow_redirect!
      assert_match content, response.body
      assert_select 'a', text: 'delete'
      first_micropost = @user.microposts.paginate(page:1).first
=begin      
      assert_difference 'Micropost.count', -1 do 
          delete microposts_path(first_micropost)
      end
=end      
  end
end

