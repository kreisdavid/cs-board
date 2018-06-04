class UserMailer < ApplicationMailer
  default from: ENV['SENDMAIL_USERNAME']

  def new_posting_email (user, post)
    @user = user
    @post = post

    mail(to: @user.email, subject: 'New Job Available for Grinnell CS Students!')
  end
end
