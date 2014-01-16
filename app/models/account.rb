class Account < ActiveRecord::Base

  @account ||= self.last
  def self.update_due_date
    all.each do |acc|
      @account = acc
      if first_of_the_month? && due_date_is_valid?
        create_dup_record
      end
    end
  end

private
  def self.due_date_is_valid?
    due_date_is_last_month || due_date_is_last_dec
  end

  def self.create_dup_record
    x = @account.dup
    x.due_date = x.due_date + 1.month
    x.save
  end

  def self.due_date_is_last_month
    @account.due_date.month == last_month && @account.due_date.year == current_year
  end

  def self.due_date_is_last_dec
    @account.due_date.month == 12 && @account.due_date.year == current_year
  end

  def self.last_month
    Date.today.ago(1.month).month
  end

  def self.current_year
    Date.today.year - 1
  end

  def self.first_of_the_month?
    Date.today == Date.today.beginning_of_month
  end

end
