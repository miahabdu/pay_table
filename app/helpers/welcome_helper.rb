module WelcomeHelper
  def account_priority(account)
    if account.priority == 1 
      'High' 
    elsif account.priority == 2 
      'Medium' 
    else 
      'Low' 
    end  
  end
end
