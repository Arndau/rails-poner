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
user3 = User.create!(email: "arnaud@gmail.com", password: "123456", first_name:"Arnaud", last_name: "Le Garrec", pseudo:"Arndau")
user4 = User.create!(email: "maxime@gmail.com", password: "123456", first_name:"Maxime", last_name: "Gourgues", pseudo:"Gorrog87")
user5 = User.create!(email: "alexandre@gmail.com", password: "123456", first_name:"Alexandre", last_name: "Meline", pseudo:"Pist4ch30")
user6 = User.create!(email: "anthony@gmail.com", password: "123456", first_name:"Anthony", last_name: "Jacquemin", pseudo:"anjacquemin")
user7 = User.create!(email: "aris@gmail.com", password: "123456", first_name:"Aris", last_name: "Gyalui", pseudo:"aris227")
user8 = User.create!(email: "celine@gmail.com", password: "123456", first_name:"Celine", last_name: "Condoris", pseudo:"Metanee97")
user9 = User.create!(email: "elie@gmail.com", password: "123456", first_name:"Elie", last_name: "Renucci", pseudo:"Eliiee")
user10 = User.create!(email: "fabrice@gmail.com", password: "123456", first_name:"Fabrice", last_name: "Kana", pseudo:"K-Fabey")
user11 = User.create!(email: "florian@gmail.com", password: "123456", first_name:"Florian", last_name: "Bel", pseudo:"Floflorifiranfan")
user12 = User.create!(email: "floriane@gmail.com", password: "123456", first_name:"Floriane", last_name: "Hibelot", pseudo:"floryhblt")
user13 = User.create!(email: "frederic@gmail.com", password: "123456", first_name:"Frederic", last_name: "Lange", pseudo:"Fred-Lange")
user14 = User.create!(email: "gary@gmail.com", password: "123456", first_name:"Gary", last_name: "Camboulives", pseudo:"daeranmoth")
user15 = User.create!(email: "julien@gmail.com", password: "123456", first_name:"Julien", last_name: "Kiang", pseudo:"iwantmycorners")
user16 = User.create!(email: "lilia@gmail.com", password: "123456", first_name:"Lilia", last_name: "Bédidi", pseudo:"LiliaBe")
user17 = User.create!(email: "louise@gmail.com", password: "123456", first_name:"Louise", last_name: "Ouldhaddi", pseudo:"Lew-Lew")
user18 = User.create!(email: "marie@gmail.com", password: "123456", first_name:"Marie", last_name: "Desjonquères", pseudo:"mariedesjonqueres")
user19 = User.create!(email: "martin@gmail.com", password: "123456", first_name:"Martin", last_name: "Dubois", pseudo:"TintinDu")
user20 = User.create!(email: "marjorie@gmail.com", password: "123456", first_name:"Marjorie", last_name: "Aubert", pseudo:"Tagada26")
user21 = User.create!(email: "martinc@gmail.com", password: "123456", first_name:"Martin", last_name: "Cavil", pseudo:"martincavil")
user22 = User.create!(email: "matthieuf@gmail.com", password: "123456", first_name:"Matthieu", last_name: "Flecher", pseudo:"Mattfl22")
user23 = User.create!(email: "matthieuv@gmail.com", password: "123456", first_name:"Matthieu", last_name: "Villeret", pseudo:"Zizanie911")
user24 = User.create!(email: "maxence@gmail.com", password: "123456", first_name:"Maxence", last_name: "Tarnaud", pseudo:"max212118")
user25 = User.create!(email: "maximeb@gmail.com", password: "123456", first_name:"Maxime", last_name: "Beaugé", pseudo:"MaximeDHH")
user26 = User.create!(email: "maximep@gmail.com", password: "123456", first_name:"Maxime", last_name: "Plasse", pseudo:"Maxplasse")
user27 = User.create!(email: "myriam@gmail.com", password: "123456", first_name:"Myriam", last_name: "Delbreil", pseudo:"Myriamdelbreil")
user28 = User.create!(email: "nicolas@gmail.com", password: "123456", first_name:"Nicolas", last_name: "Delfour", pseudo:"nicodelf")
user29 = User.create!(email: "olivier@gmail.com", password: "123456", first_name:"Olivier", last_name: "Raimbault", pseudo:"olivierescp")
user30 = User.create!(email: "pierre@gmail.com", password: "123456", first_name:"Pierre", last_name: "Coppermann", pseudo:"Pcoppy")
user31 = User.create!(email: "raphael@gmail.com", password: "123456", first_name:"Raphael", last_name: "Grelon", pseudo:"Araka42")
user32 = User.create!(email: "sofia@gmail.com", password: "123456", first_name:"Sofia", last_name: "Bellahouel", pseudo:"RYUKK31")
user33 = User.create!(email: "stephen@gmail.com", password: "123456", first_name:"Stephen", last_name: "Grieves", pseudo:"stephengrieves")
user34 = User.create!(email: "tatsiana@gmail.com", password: "123456", first_name:"Tatsiana", last_name: "Trakhimets", pseudo:"Tati-tatsiana")
user35 = User.create!(email: "thomas@gmail.com", password: "123456", first_name:"Thomas", last_name: "Voisin", pseudo:"TomVsn")
user36 = User.create!(email: "vincent@gmail.com", password: "123456", first_name:"Vincent", last_name: "Orinel", pseudo:"Vincentlenoir")

users = User.all
users.each do |user|
  user.photo.attach(io: URI.open("https://kitt.lewagon.com/placeholder/users/#{user.pseudo}"), filename: "#{user.pseudo}.jfif", content_type: 'image/jfif')
end




message1 = Message.create!(hint: "petite surprise pour toi...", address: "16 villa Gaudelet", latitude: "48.865131", longitude: "2.379999", user: user2)
message1.content = "Souvenir du Wagon !!!"
message1.save
message2 = Message.create!(hint: "ton restaurant préféré", address: "110 rue Oberkampf", latitude: "48.8659664", longitude: "2.3790391", user: user3)
message2.content = "On y mange toujours aussi bien !!"
message2.save
message3 = Message.create!(hint:"Petite bière ?", address: "cité dupont", latitude: "48.8527104", longitude: "2.3344514", user: user4)
message3.content = "Je bois à ta santé !"
message3.save
message4 = Message.create!(hint: "Bel endroit", address: "14 rue de la roquette", latitude: "48.8537039", longitude: "2.3708532", user: user6)
message4.content = "Ahhh ces beaux moments passés dans cette rue... ^^"
message4.save
message5 = Message.create!(hint: "Des voisins du Wagon", address: "Le Perchoir, 14 Rue Crespin du Gast, 75011 Paris, France", latitude: "48.8654176", longitude: "2.3819734", user: user7)
message5.content = "Coucou la team du perchoir !"
message5.save
message6 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "105 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user8)
message6.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message6.save
message7 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "107 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user9)
message7.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message7.save
message8 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "rue de belleville", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user10)
message8.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message8.save
message9 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "rue saint-maur", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user11)
message9.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message9.save
message10 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "121 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user12)
message10.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message10.save
message11 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "83 Rue Jean-Pierre Timbaud, 75011 Paris", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user13)
message11.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message11.save
message12 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "125 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user14)
message12.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message12.save
message13 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "127 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user15)
message13.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message13.save
message14 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "passage rochebrune", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user16)
message14.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message14.save
message15 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "131 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user17)
message15.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message15.save
message16 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "132 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user18)
message16.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message16.save
message17 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "112 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user19)
message17.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message17.save
message18 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "avenue jean aicard", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user20)
message18.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message18.save
message19 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "118 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user21)
message19.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message19.save
message20 = Message.create!(hint: "Le lieu de tous nos débriefs !!", address: "105 Rue Oberkampf", latitude: "48.86587142944336", longitude: "2.377452850341797", user: user22)
message20.content = "Ahh la place verte ! si on s'y retrouvait pour un verre bientôt ?"
message20.save


message_user1 = MessageUser.create!(unlocked: false, read: true, message: message1, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message2, user: user1)
# message_user1 = MessageUser.create!(unlocked: false, read: true, message: message3, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message4, user: user1)
# message_user2 = MessageUser.create!(unlocked: false, read: false, message: message2, user: user1)
# message_user3 = MessageUser.create!(unlocked: true, read: false, message: message3, user: user1)
# message_user4 = MessageUser.create!(unlocked: false, read: true, message: message4, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message5, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message6, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message7, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message8, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message9, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message10, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message11, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message12, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message13, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message14, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message15, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message16, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message17, user: user1)
message_user1 = MessageUser.create!(unlocked: true, read: true, message: message18, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message19, user: user1)
message_user1 = MessageUser.create!(unlocked: false, read: true, message: message20, user: user1)
