class Account < ActiveRecord::Base
  
  def self.update_due_date
    all.each do |acc|
      DueDateUpdater.new(acc).create_dup_record
    end
  end

end
