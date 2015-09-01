require 'test_helper'
class UserTest < ActiveSupport::TestCase
def setup
  @user = User.new(name: "Fred Hudson",
                   email: "GriTty@SymPatico.ca",
                  password: "foobar",
                  password_confirmation: "foobar")
end

test "should be valid" do
  assert @user.valid?
end
test "name should be present" do
  @user.name = " "
  assert_not @user.valid?
end
test "email should be present" do
  @user.email = " "
  assert_not @user.valid?
end
test "email should not be too long" do
  @user.email = "m" * 244 + "sympatico.ca"
  assert_not @user.valid?
end
test "email should accept valid addresses" do
  valid_addresses = %w[fred@fred.com DouG@doug.com PPPP@PPP.org
                      Sma-sam-san-.sam@doug.com]
  valid_addresses.each do |valid_address|
    @user.email = valid_address
    assert @user.valid?, "#{ valid_address.inspect } should be valid"
  end
end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com  
    fooo.bar@bar...org]
     invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, 
        "#{invalid_address.inspect} should be invalid"
      end
  end
    test "email validation should be unique" do 
      dup_user = @user.dup
      @user.save
      dup_user.email = @user.email.upcase
      assert_not dup_user.valid?
    end

    test "ensure password was downcased" do 
      @user.save
      user_with_downcased_email = @user.reload.email
      assert_equal user_with_downcased_email, @user.email.downcase
    end

    #~~~~~~~~~~~~~~~~~~~~~~~
    #Password Validations
    test "password should be present and (nonblank)"  do 
      @user.password = @user.password_confirmation =  " " * 6
      assert_not @user.valid?
        
    end

    test "password should have a minimum length" do 
        @user.password = @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end
        
    end
  # test "the truth" do
  #   assert true
  # end
    
