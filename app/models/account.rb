class Account < ActiveRecord::Base
  validates :amount_due, presence: true, numericality: true
  validates :due_date, presence: true

  belongs_to :user

  scope :by_user,           ->(id) { where(user_id: id)}
  scope :for_current_month, ->     { where(due_date_month: Date.today.month.to_s, due_date_year: Date.today.year.to_s)}
  scope :for_last_month,    ->     { where(due_date: Date.today.beginning_of_year..Date.today.last_month.end_of_month)}
  scope :for_next_month,    ->     { where(due_date_month: (Date.today.month + 1).to_s, due_date_year: (Date.today.year).to_s)}
  scope :paid,              ->     { where(is_paid: true)}
  scope :unpaid,            ->     { where(is_paid: false)}

  def self.update_due_date
    all.each do |acc|
      DueDateUpdater.new(acc).create_dup_record
    end
  end

  def mk_bal
    ActionController::Base.helpers.number_to_currency(self.amount_due, :precision => 2)
  end

 def self.chart_data(start = (Date.today.beginning_of_month - 1.day).to_date)
    total_prices = prices_by_day(start)
    paid = where(is_paid: true).prices_by_day(start)
    unpaid = where(is_paid: false).prices_by_day(start)
    # total_unpaid = where(is_paid: false).prices_by_day(start)
    (start..Date.today.end_of_month).map do |date|
      {
        due_date: date,
        amount_due: total_prices[date] || 0,
        paid: paid[date] || 0,
        unpaid: unpaid[date] || 0,
        total_unpaid: current_total(date) || 0
      }
    end
  end

  def self.prices_by_day(start)
    plots = where(due_date: start.beginning_of_day..Time.zone.now.end_of_month.to_date)
    plots = plots.group("date(due_date)")
    plots = plots.select("due_date, sum(amount_due) as total_due")
    plots.each_with_object({}) do |plot, prices|
      prices[plot.due_date.to_date] = plot.total_due
    end
  end

  def self.current_total(date)
    total = where("is_paid = ? AND due_date <= ?", false, date).map(&:amount_due).sum
  end

  def self.counts
    [{label: 'Unpaid Accounts', value: for_current_month.unpaid.count}, {label: 'Paid Accounts', value: for_current_month.paid.count}]
  end

  def self.category_percents
    total = for_current_month.pluck(:amount_due).sum
    categories = for_current_month.pluck(:category).uniq
    results = []
    categories.each do |c|
      results << {label: c, value: (for_current_month.where(category: c).pluck(:amount_due).sum / total).to_f.round(2) * 100 }
    end
    results
  end

  def self.category_totals
    categories = for_current_month.pluck(:category).uniq
    results = []
    categories.each do |c|
      results << {label: c, value: for_current_month.where(category: c).pluck(:amount_due).sum.to_f }
    end
    results
  end

end
