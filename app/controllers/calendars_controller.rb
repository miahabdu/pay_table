class CalendarsController < ApplicationController
  def index
  end

  def calendar_dates
    dates = AccountCalendar.new(Account.all).dates

    render :json => dates.to_json
  end
end
