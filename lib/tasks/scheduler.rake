desc "Update all accounts for the next month"
task :update_accounts => :environment do
  puts "Updating accounts..."
  if Date.today.day == 24
    Account.update_due_date
  end
  puts "done."
end