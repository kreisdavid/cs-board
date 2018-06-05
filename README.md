## Job board for the Grinnell CS department

Allows alumni to post opportunities for undergraduates through a secure portal.

This repository is a public copy of the private repository used to create this site for a class at Grinnell College.

Screenshots of the site in use can be found in cs-jobs-site-screenshots.zip

### Development notes


To change an user to an admin:
```
rails c
usr = User.where(:email => 'username@grinnell.edu')
usr.first.update_attribute(:is_admin,true)
```

To schedule regular archiving add this to your crontab file:
```
15 * * * * cd grinnell-cs-job-board && rake RAILS_ENV=production posts:archive_posts
```
