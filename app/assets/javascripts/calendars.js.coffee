# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).ready ->
    $.get '/calendars/calendar_dates', (data) ->
      $("#calendar").fullCalendar
        header:
          left: "month,agendaWeek,agendaDay"
          center: "title"
          right: "today prev,next"
        events: data
        eventBackgroundColor: '#278ccf'