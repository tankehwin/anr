desc "Refill Boost Tank"
task :refill => ["tank:refill"]

namespace :tank do
  desc "Refill Boost Tank To Tank Limit"
  task :refill => :environment do
    puts "Refilling all Organizer Boost Tank..."
    Organizer.find(:all, :conditions => ["active = ?", true]).each do |organizer|
	  organizer.boost_tank_current_amount = organizer.boost_tank_full_limit
	  organizer.save
	  print "#{organizer.id}..."
	  STDOUT.flush
    end
    puts "Done!"
  end

  desc "Refill Boost Tank to Double Tank Limit"
  task :double => :environment do
    puts "Refilling all Organizer Boost Tank (Doubled!)..."
    Organizer.find(:all, :conditions => ["active = ?", true]).each do |organizer|
    organizer.boost_tank_current_amount = organizer.boost_tank_full_limit * 2
    organizer.save
    print "#{organizer.id}..."
    STDOUT.flush
    end
    puts "Done!"
  end
end
