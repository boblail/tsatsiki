require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "username only supports letters and numbers" do
    user = User.new(:username => "alphabet5")
    user.valid?
    assert_equal false, user.errors[:username].any?
    
    user = User.new(:username => "wrong-123")
    user.valid?
    assert_equal true, user.errors[:username].any?
    
    user = User.new(:username => "@taglike")
    user.valid?
    assert_equal true, user.errors[:username].any?
  end
  
end
