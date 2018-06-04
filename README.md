## Job board for the Grinnell CS department

Allows alumni to post opportunities for undergraduates through a secure portal.

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
