Recaptcha.configure do |config|
    config.site_key = '6LdIHB0UAAAAALP00MXpMJ4F_vDOppnhqFB_uAt9'
    config.secret_key = '6LdIHB0UAAAAAIhiFNzRwGQloWH8hDZPe3C9UClO'
end

#probably bad to store secret key in repo like this
# keeping it for production, upon release, look to this site:
#### https://richonrails.com/articles/adding-recaptcha-to-your-rails-application