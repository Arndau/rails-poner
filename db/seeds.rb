# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Message.destroy_all
MessageUser.destroy_all


user1 = User.create!(email: "guillaume@test.com", password: "123456", first_name:"Guillaume", last_name: "Levasseur")
user2 = User.create!(email: "amaury@gmail.com", password: "123456", first_name:"Amaury", last_name: "Vallet")
user3 = User.create!(email: "Arnaud@gmail.com", password: "123456", first_name:"Arnaud", last_name: "Le Garrec")
user4 = User.create!(email: "maxime@gmail.com", password: "123456", first_name:"maxime", last_name: "Gourgues")


message1 = Message.create!(hint: "pettie surprise pour toi...", address: "16 villa Gaudelet", lat: "48.865131", long: "2.379999")
#message2 = Message.create!(hint: "ton restaurant préféré", address: "110 rue Oberkampf", lat: "48.866667", long: "2.333333")
