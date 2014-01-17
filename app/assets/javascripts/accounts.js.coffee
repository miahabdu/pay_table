# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on "click", "#accounts th a", ->
    $.getScript @href
    false
    
  $.datepicker.setDefaults dateFormat: "yy-mm-dd"
  $('#addAccount').click ->
    $('#newAccountForm').slideDown "fast", ->
      $('#newAccountForm').show()
    
  $('#close').click ->
    $('#newAccountForm').slideUp "fast", ->
      $('#newAccountForm').hide()
  $('.best_in_place').best_in_place()