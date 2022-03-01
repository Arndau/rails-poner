# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MessageUser.destroy_all
Message.destroy_all
User.destroy_all

user1 = User.create!(email: "guillaume@test.com", password: "123456", first_name:"Guillaume", last_name: "Levasseur")
user2 = User.create!(email: "amaury@gmail.com", password: "123456", first_name:"Amaury", last_name: "Vallet")
user3 = User.create!(email: "Arnaud@gmail.com", password: "123456", first_name:"Arnaud", last_name: "Le Garrec")
user4 = User.create!(email: "maxime@gmail.com", password: "123456", first_name:"maxime", last_name: "Gourgues")

message1 = Message.create!(hint: "pettie surprise pour toi...", address: "16 villa Gaudelet", latitude: "48.865131", longitude: "2.379999", user: user1)
message2 = Message.create!(hint: "ton restaurant préféré", address: "110 rue Oberkampf", latitude: "48.8659664", longitude: "2.3790391", user: user2)
message3 = Message.create!(hint:"test test", address: "rue princesse", latitude: "48.8527104", longitude: "2.3344514", user: user3)
message4 = Message.create!(hint: "Bel endroit", address: "14 rue de la roquette", latitude: "48.8537039", longitude: "2.3708532", user: user4)

message_user1 = MessageUser.create!(unlocked: true, read: true, message: message1, user: user2)
message_user2 = MessageUser.create!(unlocked: false, read: false, message: message2, user: user3)
message_user3 = MessageUser.create!(unlocked: true, read: false, message: message3, user: user4)
message_user4 = MessageUser.create!(unlocked: false, read: true, message: message4, user: user1)
