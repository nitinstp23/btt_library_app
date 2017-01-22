# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Create Admin
AdminUser.where(email: 'nitin@mobmerry.com').first_or_initialize.tap do |user|
  user.first_name = 'Nitin'
  user.last_name  = 'Misra'
  user.password   = 'password'
end.save!
