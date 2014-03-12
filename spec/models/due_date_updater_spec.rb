require 'spec_helper'

describe DueDateUpdater do

  describe '#create_dup_record' do
    it "should create a new Account by duplicating existing account" do
      account = Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Credit Card', is_paid: true, due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s, category: 'Credit Card')
      expect { 
        DueDateUpdater.new(account).create_dup_record 
      }.to change(Account, :count).by(1)
    end
  end

end
