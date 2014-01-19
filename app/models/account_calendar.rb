class AccountCalendar
  attr_accessor :accounts

  def initialize(accounts)
    @accounts = accounts
  end

  def calendar_days
    accounts.map{|d| d.strftime("%d")}
  end

  def calendar_months
    accounts.map{|m| m.strftime("%m")}
  end

  def calendar_years
    accounts.map{|m| m.strftime("%Y")}
  end

  def calendar_account_names
    accounts.map(&:name)
  end

  def dates
    results = []
    accounts.each do |account|
      results << {title: "#{account.name} -- $#{"%.2f" %account.amount_due}", start: account.due_date, allDay: false}
    end
    # results = {}
    # results[:calendar_days]            = calendar_days
    # results[:calendar_months]          = calendar_months
    # results[:calendar_years]           = calendar_years
    # results[:calendar_account_names]   = calendar_account_names

    results
  end

  # def format
  #   [{
  #     "title":"Resourse for Paths ",
  #     "start":"2011-11-08T07:30:00Z",
  #     "end":"2011-11-08T10:30:00Z",
  #     "allDay":false
  #   }]
  # end
end