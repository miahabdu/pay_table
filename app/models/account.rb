class Account < ActiveRecord::Base
  
  def self.update_due_date
    all.each do |acc|
      DueDateUpdater.new(acc).create_dup_record
    end
  end

  def mk_bal
    ActionController::Base.helpers.number_to_currency(self.amount_due, :precision => 2)
end

end
