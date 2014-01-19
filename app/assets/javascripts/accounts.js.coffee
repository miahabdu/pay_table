# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  cacluateAccountTotals = ->
    $.get '/accounts/account_totals', (data) ->
      data.current_month_paid_expenses = parseFloat(data.current_month_paid_expenses)
      data.current_month_unpaid_expenses = parseFloat(data.current_month_unpaid_expenses)
      data.current_month_total_expenses = parseFloat(data.current_month_total_expenses)
      data.total_expenses_ytd = parseFloat(data.total_expenses_ytd)
      rendered_template = Mustache.render($('#account_totals_template').html(), data)
      $('#analytics').html(rendered_template).show()
  
  $(document).on "click", "#accounts th a", ->
    $.getScript @href
    false

  $.datepicker.setDefaults dateFormat: "yy-mm-dd"
  $(".datepicker").pickadate
    format: "yyyy-mm-dd"

  $('#addAccount').click ->
    $('#newAccountForm').slideDown "fast", ->
      $('#newAccountForm').show()
    
  $('#close').click ->
    $('#newAccountForm').slideUp "fast", ->
      $('#newAccountForm').hide()
  $('.best_in_place').best_in_place()

  $(document).ready ->
    cacluateAccountTotals()
    $.get '/calendars/calendar_dates', (data) ->
      $("#calendar").fullCalendar
        header:
          left: "month,agendaWeek,agendaDay"
          center: "title"
          right: "today prev,next"
        events: data
        eventBackgroundColor: '#278ccf'
    
  $(".best_in_place").bind "ajax:success", -> 
    cacluateAccountTotals()