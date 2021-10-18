(function() {
  $(document).on('turbolinks:load', function() {
    return $('#flash').delay(1500).fadeOut('slow');
  });

}).call(this);
