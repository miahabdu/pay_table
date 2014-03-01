module WelcomeHelper
  def account_priority(account)
    if account.priority == 1 
      raw("<button class='btn btn-danger btn-xs'><i class='fa fa-warning'></i> High</button>") 
    elsif account.priority == 2 
      raw("<button class='btn btn-warning btn-xs'><i class='fa'></i> Medium</button>") 
    else 
      raw("<button class='btn btn-info btn-xs'><i class='fa'></i> Low</button>") 
    end  
  end
end
