// This example makes use of jQuery to help smooth out browser differences. Also it
// uses JSONP for the cross-origin request for greater browser compatability.
jQuery(function($) {
  Validator.registerFields();
  $('form').submit(function(e) {
    e.preventDefault();

    $form = $(this);
    Spreedly.create_payment_method_url =  $form.attr('action');

    Validator.perform();
    if ($('input.invalid').length) {
      $('.validation').addClass('failed');
    } else {
      $('.validation').addClass('passed');
      Spreedly.add_payment_method(
        Booking.buildCard(),
        Booking.handleToken,
        Booking.handleTransmissionError
      );
    }
  });
});

Spreedly = {
  add_payment_method: function(card, success, error) {
    // JSONP sends non-nested data, so this specifies the type.
    card["kind"] = "credit_card";
    card["environment_key"] = Spreedly.environment_key;

    var paramStr = $.param(card);
    var url = Spreedly.create_payment_method_url + ".js?" + paramStr

    $.ajax({
      type: "GET",
      url: url,
      dataType: "jsonp",
      success: success,
      error: error,
    });
  }
}

Booking = {
  buildCard: function() {
    return {
      "first_name": $('#credit_card_first_name').val(),
      "last_name": $('#credit_card_last_name').val(),
      "number": $('#credit_card_number').val(),
      "verification_value": $('#credit_card_verification_value').val().replace(/\s/g, ''),
      "month": $('#credit_card_exp').val().split("/")[0].trim(),
      "year": $('#credit_card_exp').val().split("/")[1].trim()
    }
  },
  handleToken: function(data) {
    Validator.reset();
    if (data.status === 201) {
      $.ajax({
        type: 'POST',
        url: '/process',
        data: {
          payment_method_token: data.transaction.payment_method.token,
          rooms: $('#rooms').val()
        },
        success: Booking.handleBookingResponse,
        error: function(data) { alert("Booking system unavailable.") },
        dataType: "json",
      });
    } else {
      Booking.displaySpreedlyValidationMessages(data.errors);
    }
  },
  handleTransmissionError: function(data) {
    Validator.reset();
    alert('Cannot reach server. Please try again later.');
  },
  displaySpreedlyValidationMessages: function(errors) {
    $.each(errors, function(index, error) {
      alert(error.message);
    });
  },
  handleBookingResponse: function(data) {
    window.location.href = "/confirmation";
  }
}
