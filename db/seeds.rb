# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

Meetup.create( title: 'Pies for everyone', description: 'Freakin pies man!', location: 'Pie store' )
Meetup.create( title: 'Launcher Lunch', description: 'Get lunch with fellow Launchers', location: 'Chinatown' )
Meetup.create( title: 'Free kitten day', description: 'Get a cat or something', location: 'A box on the corner' )
Meetup.create( title: 'Trampoline party', description: 'Jump and stuff', location: 'The trampoline park' )

User.create( provider: 'github', uid: 'gitub4', email: 'thatguy@gmail.com', username: 'ThatGuy', avatar_url: 'thatguy.com')
User.create( provider: 'github1', uid: 'gitub5', email: 'poindexter@aol.com', username: 'Poindexter', avatar_url: 'poindexter.com')
User.create( provider: 'github2', uid: 'gitub6', email: 'alf@gmail.com', username: 'Alf', avatar_url: 'itsalf.com')
User.create( provider: 'github3', uid: 'gitub7', email: 'billypancakes@gmail.com', username: 'jackwaffles', avatar_url: 'breakfastitems.com')


Attendee.create(meetup_id: 1, user_id: 1, owner: true)
Attendee.create(meetup_id: 1, user_id: 2, owner: false)
Attendee.create(meetup_id: 1, user_id: 4, owner: false)
Attendee.create(meetup_id: 2, user_id: 1, owner: false)
Attendee.create(meetup_id: 2, user_id: 4, owner: true)
Attendee.create(meetup_id: 3, user_id: 3, owner: true)
Attendee.create(meetup_id: 4, user_id: 2, owner: false)
Attendee.create(meetup_id: 4, user_id: 1, owner: false)
Attendee.create(meetup_id: 4, user_id: 3, owner: true)
