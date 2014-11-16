# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

usernames = %w(Xavier Jared Mike Andrew Stephen Nathan)
emails = usernames.map(&:downcase).map {|name| name + "@gmail.com"}

usernames.each_with_index do |username, index|
  user = User.new
  user.name = username
  user.email = emails[index]
  user.password = "password123"
  user.password_confirmation = "password123"
  user.save!
end

user2 = User.new
user2.name = "Smart Teacher"
user2.email = "teacher@gmail.com"
user2.password = "password123"
user2.password_confirmation = "password123"
user2.role = 1
user2.save!

room1 = Room.create(name: "chem141")
room2 = Room.create(name: "cs101")

user2.rooms << room1
user2.rooms << room2

questions = []
answers = []



questions << "What is the command for printing out in ruby?"
answers << ["puts","print","println","printf"]

questions << "What does coffeescript compile down to?"
answers << ["C", "Javascript", "Ruby", "Cocoa"]

questions << "How many bits are in a byte on a 32-bit system?"
answers << ["8", "16", "32", "64"]

questions << "Which of these allows you to keep a HTTP connection open?"
answers << ["AJAX", "Curl", "HTTParty", "Websocket"]

questions << 'What does "2" == "2" evaluate to in Java?'
answers << ["true", "false", "NaN", "Segfault"]



questions << "What is the symbol for Hydrogen?"
answers << ["He", "Hy", "H"]

questions << "What is the weight of Carbon in amu?"
answers << ["10", "11", "12"]

questions << "How many valence electrons does Oxygen have?"
answers << ["8", "16", "10", "6"]

questions << "Is Nitrogen considered a Halogen?"
answers << ["Yes", "No", "Sometimes"]

questions << "What group does Xenon belong to?"
answers << ["Halogens", "Noble Gases", "Alkali Earth Metals"]



questions.map!.with_index do |description, i|
  Question.new(description: description, order: i)
end


answers.map! do |answer_arr|
  answer_arr.map!.with_index do |description, i|
    Answer.new(description: description, order: i)
  end
end

questions.each_with_index do |question, index|
  question.answers += answers[index]
end


(0..4).each do |i|
  room2.questions << questions[i]
  room2.save!
end


(5..9).each do |i|
  room1.questions << questions[i]
  room1.save!
end

room1.save!
room2.save!

questions.map(&:save)
answers.each {|choices| choices.map(&:save)}







