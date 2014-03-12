require 'spec_helper'

describe AccountTotals do
  # let(:accounts) { [, Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Credit Card', is_paid: false) ] }
  subject { AccountTotals.new(Account.all) }
  
  before do 
    paid_account = Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Credit Card', is_paid: true, due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s)
    unpaid_account = Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Credit Card', is_paid: false, due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s)
  end
  
  describe 'current month paid expenses' do
    it 'should return total of paid amounts' do
      subject.current_month_paid_expenses.should == 150.0
    end

    it 'should return count of paid amounts' do
      subject.current_month_paid_expenses_count.should == 1
    end
  end

  describe 'current month unpaid expenses' do
    it 'should return total of paid amounts' do
      subject.current_month_unpaid_expenses.should == 150.0
    end

    it 'should return count of upaid amounts' do
      subject.current_month_unpaid_expenses_count.should == 1
    end
  end

  describe 'current month totals' do
    it 'should return total expenses' do
      subject.current_month_total_expenses.should == 300.0
    end
  end

  describe 'current year totals' do
    it 'should return total expenses' do
      subject.total_expenses_ytd.should == 300.0
    end
  end

  describe 'totals' do
    it 'should return hash of values' do
      subject.totals.should == {:current_month_paid_expenses => 150.0, :current_month_paid_expenses_count => 1, :current_month_unpaid_expenses => 150.0, :current_month_unpaid_expenses_count => 1, :current_month_total_expenses => 300.0, :total_expenses_ytd => 300.0}
    end
  end
end