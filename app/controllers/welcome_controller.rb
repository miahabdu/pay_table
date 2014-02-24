class WelcomeController < ApplicationController
  def index
    @accounts = Account.by_user(current_user.id).for_current_month
  end
end
