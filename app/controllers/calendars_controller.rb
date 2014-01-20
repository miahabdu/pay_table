class CalendarsController < ApplicationController
  def index
  end

  def calendar_dates
    dates = AccountCalendar.new(Account.by_user(current_user.id)).dates

    render :json => dates.to_json
  end
end
