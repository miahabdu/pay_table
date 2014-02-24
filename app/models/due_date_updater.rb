class DueDateUpdater
  def initialize(account)
    @account = account
  end

  def due_date_is_valid?
    due_date_is_current_month || due_date_is_last_dec
  end

  def create_dup_record
    return false unless due_date_is_valid?
    x = @account.dup
    x.due_date = x.due_date + 1.month
    x.save
  end

  def due_date_is_current_month
    @account.due_date.month == last_month && @account.due_date.year == current_year
  end

  def due_date_is_last_dec
    @account.due_date.month == 12 && @account.due_date.year == current_year
  end

  def last_month
    Date.today.month
  end

  def current_year
    Date.today.year
  end

  def first_of_the_month?
    Date.today == Date.today.beginning_of_month
  end

end