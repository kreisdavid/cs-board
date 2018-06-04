require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:test_user)
    @post = posts(:one)
  end

  # Test new posting alert email
  test "new_posting" do
    email = UserMailer.new_posting_email(@user, @post)


    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ENV['SENDMAIL_USERNAME']], email.from
    assert_equal [@user.email], email.to
    assert_equal 'New Job Available for Grinnell CS Students!', email.subject

    # I'm not sure how to test the contents of the email since they're contained in the view, not the email object.

  end

end
