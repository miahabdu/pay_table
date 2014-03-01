module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = (column == sort_column) && (sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction), {:class => css_class}
  end

  def account_category(category)
    case category
    when 'Mortgage/Rent'
      raw("<i class='category fa fa-home fa-lg' data-toggle='tooltip' data-placement='bottom' title='Mortgage/Rent''></i>")
    when 'Credit Card'
      raw("<i class='category fa fa-credit-card fa-lg' data-toggle='tooltip' data-placement='bottom' title='Credit Card'></i>")
    when 'Entertainment'
      raw("<i class='category fa fa-ticket fa-lg' data-toggle='tooltip' data-placement='bottom' title='Entertainment'></i>")
    when 'Insurance'
      raw("<i class='category fa fa-shield fa-lg' data-toggle='tooltip' data-placement='bottom' title='Insurance'></i>")
    when 'Auto Payment'
      raw("<i class='category fa fa-road fa-lg' data-toggle='tooltip' data-placement='bottom' title='Auto Payment'></i>")
    when 'Food/Dining'
      raw("<i class='category fa fa-cutlery fa-lg' data-toggle='tooltip' data-placement='bottom' title='Food/Dining'></i>")
    when 'Utilities'
      raw("<i class='category fa fa-lightbulb-o fa-lg' data-toggle='tooltip' data-placement='bottom' title='Utilities'></i>")
    when 'Health/Fitness'
      raw("<i class='category fa fa-heart fa-lg' data-toggle='tooltip' data-placement='bottom' title='Health/Fitness'></i>")
    when 'Loan'
      raw("<i class='category fa fa-money fa-lg' data-toggle='tooltip' data-placement='bottom' title='Loan'></i>")
    when 'Groceries'
      raw("<i class='category fa fa-shopping-cart fa-lg' data-toggle='tooltip' data-placement='bottom' title='Groceries'></i>")
    else
      raw("<i class=''></i>")
    end  
  end
end
