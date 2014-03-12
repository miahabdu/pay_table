require 'spec_helper'

describe Account do
  subject { Account }

  before do 
    paid_account = Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Credit Card', is_paid: true, due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s, category: 'Credit Card')
    unpaid_account = Account.create!(due_date: Date.today, amount_due: 150.0, name: 'Gas Bill', is_paid: false, due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s, category: 'Utilities')
  end

  describe 'chart data for morris graph' do 
    it 'should return hash of data for each day of the month' do
      days = Date.today.next_month.beginning_of_month - Date.today.last_month.end_of_month
      chart_days = days.to_s.chars.take(2).join.to_i
      subject.chart_data.size.should == chart_days
    end
  end

  describe 'current total for morris graph val' do
    it 'should return sum of total unpaid accounts by date' do
      subject.current_total(Date.today).should == 150.0
    end
  end

  describe 'counts morris donut chart' do
    it 'should return array hash of paid and unpaid accounts count' do
      subject.counts.should == [{:label => "Unpaid Accounts", :value => 1}, {:label => "Paid Accounts", :value => 1}]
    end
  end

  describe 'category percents morris donut chart' do
    it 'should return array hash of paid and unpaid category percents' do
      subject.category_percents.should == [{:label => "Credit Card", :value => 50}, {:label => "Utilities", :value => 50}]
    end
  end

  describe 'category totals morris donut chart' do
    it 'should return array hash of paid and unpaid category totals' do
      subject.category_totals.should == [{:label => "Credit Card", :value => 150.0}, {:label => "Utilities", :value => 150.0}]
    end
  end
end
