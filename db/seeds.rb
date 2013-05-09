# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding.."

# config
number_of_player = 9
number_of_tournament = 2

Player.delete_all
Player.create({:id => 1, :username => "MY00000", :email => "admin@sentulasia.com", :name => "Bye"}, :as => :seed)
puts "Seeding #{number_of_player} players..."
(1..number_of_player).each do |p|
  Player.create :username => "MY0000" + p.to_s,
  :email => "player#{p}@sentulasia.com",
  :name => "Player #{p}"
  print "#{p}..."
  STDOUT.flush
end
puts "Done!"

Tournament.delete_all
Participant.delete_all
puts "Seeding #{number_of_tournament} tournaments..."
(1..number_of_tournament).each do |t|
  tournament = Tournament.create :name => "Tournament " + t.to_s
  print "#{t}..."
  STDOUT.flush
end
puts "Done!"

puts "Seeding Done!"
