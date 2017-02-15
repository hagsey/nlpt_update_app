// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// Update date field with current day

$(document).on('turbolinks:load', function() {

  var today = new Date(),
    day = today.getDate(),
    month = today.getMonth() + 1,
    year = today.getFullYear();

  if (day < 10) {
    day = '0' + day;
  }

  if (month < 10) {
    month = '0' + month;
  }

  today = year + '-' + month + '-' + day;

  $("#update-form-date").val(today); 
});
