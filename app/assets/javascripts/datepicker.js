$(document).ready(function() {
  $('.input-group.date').datepicker({
    startDate: '01/01/2000',
    endDate: '12/31/2050',
    orientation: "bottom auto",
    todayHighlight: true,
    format: {
      toDisplay: function(date) {
        return 'YYYY/MM/DD'
      };
      toValue: function(date) {
        return 'MM/DD/YYYY'
      };
    // {
    //   toValue: function(date, format) {
    //     var ruby_parsable_string = date.getFullYear()+ '-' + date.getMonth() + '-' + date.getDate()
    //     return ruby_parsable_string
    //   }
    // }
  })
})
