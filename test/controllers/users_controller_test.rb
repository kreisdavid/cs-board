require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:test_user)
    sign_in @user
  end

  test "toggle_get_notifications" do
    #get :toggle_get_notifactions, id: @user.id
    assert !@user.wants_notifications
    assert ("@user.wants_notifications") do
      get :toggle_get_notifactions, id: @user.id
    end
    assert ("!@user.wants_notifications") do
      get :toggle_get_notifactions, id: @user.id
    end
  end
end
