# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = 'a'
user2 = 'b'
game = Game.create(user: user1)
game.markers.create(user: user1, index_num: 1)
game.markers.create(user: user2, index_num: 4)
game.markers.create(user: user1, index_num: 2)
game.markers.create(user: user2, index_num: 5)
