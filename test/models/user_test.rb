require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:test_user)
    @post = posts(:one)
  end

  test "toggle_save" do
    assert_difference("@user.posts.length") do
      @user.toggle_save(@post)
    end
    assert_difference("@user.posts.length",-1) do
      @user.toggle_save(@post)
    end
  end
end
