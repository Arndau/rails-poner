require "open-uri"

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


user1 = User.create!(email: "guillaume@gmail.com", password: "123456", first_name:"Guillaume", last_name: "Levasseur", pseudo:"krishland")
user2 = User.create!(email: "amaury@gmail.com", password: "123456", first_name:"Amaury", last_name: "Vallet", pseudo:"AmauryVALLET")
user3 = User.create!(email: "arnaud@gmail.com", password: "123456", first_name:"Arnaud", last_name: "LeGarrec", pseudo:"Arndau")
user4 = User.create!(email: "maxime@gmail.com", password: "123456", first_name:"Maxime", last_name: "Gourgues", pseudo:"Gorrog87")
user5 = User.create!(email: "matthieuv@gmail.com", password: "123456", first_name:"Matthieu", last_name: "Villeret", pseudo:"Zizanie911")
user6 = User.create!(email: "nicolas@gmail.com", password: "123456", first_name:"Pierre-Yves", last_name: "LeGuennec", pseudo:"pyveslg")
user7 = User.create!(email: "mylene@gmail.com", password: "123456", first_name:"Mylene", last_name: "Moreau", pseudo:"Mylhouse")
user8 = User.create!(email: "diane@gmail.com", password: "123456", first_name:"Diane", last_name: "Roussillon", pseudo:"dianejroussillon")
user9 = User.create!(email: "tamara@gmail.com", password: "123456", first_name:"Tamara", last_name: "DeGaetano", pseudo:"tamaradg")





users = User.all
users.each do |user|
  user.photo.attach(io: URI.open("https://kitt.lewagon.com/placeholder/users/#{user.pseudo}"), filename: "#{user.pseudo}.jfif", content_type: 'image/jfif')
end




message1 = Message.create!(hint: "Petite surprise pour toi...", address: "19 Rue Moret, 75011 Paris", latitude: "48.865131", longitude: "2.379999", user: user2)
message1.content = "Souvenir du Wagon !!!"
message1.save
message2 = Message.create!(hint: "ton restaurant préféré", address: "110 rue Oberkampf", latitude: "48.8659664", longitude: "2.3790391", user: user3)
message2.content = "On y mange toujours aussi bien !!"
message2.save
message3 = Message.create!(hint:"Petite bière ?", address: "32 Rue Saint-Maur, 75011 Paris", latitude: "48.8527104", longitude: "2.3344514", user: user4)
message3.content = "Je bois à ta santé !"
message3.save
message4 = Message.create!(hint: "Je te laisse découvrir ce restaurant parfait pour les amoureux !", address: "11 Rue Civiale, 75010 Paris", latitude: "48.8537039", longitude: "2.3708532", user: user5)
message4.content = "Ahhh ces beaux moments passés à table"
message4.save
message5 = Message.create!(hint: "Des voisins du Wagon", address: "Le Perchoir, 14 Rue Crespin du Gast, 75011 Paris, France", latitude: "48.8654176", longitude: "2.3819734", user: user6)
message5.content = "Coucou la team du perchoir !"
message5.save
message6 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "105 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user7)
message6.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message6.save
message7 = Message.create!(hint: "Tu n'oublies rien ?!", address: "107 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user8)
message7.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message7.save
message8 = Message.create!(hint: "Un peu de courage pour cette DemoDay 😘", address: "16 villa gaudelet", latitude: "48.86487224057384", longitude: "2.3797483921518188", user: user9)
message8.content = "Regarde derrière la plante de Akagreen ❤️"
message8.save
message8.photo.attach(io: URI.open("https://res.cloudinary.com/guillaumelevcloud/image/upload/v1646994094/development/Message_Tamara_obybka.jpg"), filename: "Message_Tamara_obybka.jpg", content_type: 'image/jpg')
message8.save
message8.latitude = "48.8648863"
message8.save
message8.longitude = "2.3797953"
message8.save
message8.created_at = Date.new(2022, 3, 10)
message8.save

message_user1 = MessageUser.create!(unlocked: false, read: true, message: message1, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message2, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message3, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message4, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message5, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message6, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message7, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message8, user: user1)
