require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Real Rails Application"
    assert_equal full_title("Help"), "Help | Real Rails Application"
    assert_equal full_title("Contact"), "Contact | Real Rails Application"
    assert_equal full_title("About"), "About | Real Rails Application"
  end
end
