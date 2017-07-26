# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# created_at: Time.now, updated_at: (Time.now + 30.minutes),
# created_at: Time.now, updated_at: (Time.now + 30.minutes),
# created_at: Time.now, updated_at: (Time.now + 30.minutes),
GameSession.create(score: "1000",  games_id:1 , users_id:1)
GameSession.create(score: "2000",  games_id:2 , users_id:1)
GameSession.create(score: "3000",  games_id:3 , users_id:1)

User.create(email: "Tyrion@KingsLanding.co", encrypted_password: "valid_password")
User.create(email: "Cersei@KingsLanding.co", encrypted_password: "valid_password")
User.create(email: "Arya@HouseStark.co", encrypted_password: "valid_password")

Game.create(title: "Espidi Capriles", body: "Move fast like Sonic", url: "http://newgrounds.com/")
Game.create(title: "Got Dem Feelz", body: "Move fast like Sonic", url: "http://newgrounds.com/")
Game.create(title: "Not That DS Mario Game", body: "Move fast like Sonic", url: "http://newgrounds.com/")
