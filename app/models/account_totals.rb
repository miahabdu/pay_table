class AccountTotals
  attr_accessor :accounts

  def initialize(accounts)
    @accounts = accounts
  end

  def current_month_paid_expenses
    accounts.paid.for_current_month.pluck(:amount_due).sum
  end

  def current_month_paid_expenses_count
    accounts.paid.for_current_month.count
  end

  def current_month_unpaid_expenses
    accounts.unpaid.where(due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s).pluck(:amount_due).sum
  end

  def current_month_unpaid_expenses_count
    accounts.unpaid.for_current_month.count
  end

  def current_month_total_expenses
    accounts.for_current_month.pluck(:amount_due).sum
  end

  def total_expenses_ytd
    accounts.pluck(:amount_due).sum
  end

  def totals
    results = {}
    results[:current_month_paid_expenses]            = current_month_paid_expenses
    results[:current_month_paid_expenses_count]      = current_month_paid_expenses_count
    results[:current_month_unpaid_expenses]          = current_month_unpaid_expenses
    results[:current_month_unpaid_expenses_count]    = current_month_unpaid_expenses_count
    results[:current_month_total_expenses]           = current_month_total_expenses
    results[:total_expenses_ytd]                     = total_expenses_ytd

    results
  end
end