class DueDateUpdater
  def initialize(account)
    @account = account
  end

  def due_date_is_valid?
    due_date_is_current_month_and_year
  end

  def create_dup_record
    return false unless due_date_is_valid?
    x = @account.dup
    x.due_date = x.due_date + 1.month
    x.due_date_month = x.due_date.month
    x.due_date_year = x.due_date.year
    x.is_paid = false
    x.save
  end

  def due_date_is_current_month_and_year
    @account.due_date.month == current_month && @account.due_date.year == current_year
  end

  def current_month
    Date.today.month
  end

  def current_year
    Date.today.year
  end

end