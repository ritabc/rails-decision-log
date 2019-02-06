$(document).ready(function() {
  $('.input-group.date').datepicker({
    format: 'mm-dd-yyyy',
    startDate: '01-01-2000',
    endDate: '12-31-2050',
    orientation: "bottom auto",
    todayHighlight: true
  })
})
