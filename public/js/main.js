jQuery(function($) {
  Validator.registerFields();
  $('form').submit(function(e) {
    e.preventDefault();

    Validator.perform();
    if ($('input.invalid').length) {
      $('.validation').addClass('failed');
    } else {
      $('.validation').addClass('passed');
      var card = {
        "environment_key": Spreedly.environment_key,
        "kind": "credit_card",
        "first_name": $('#credit_card_first_name').val(),
        "last_name": $('#credit_card_last_name').val(),
        "number": $('#credit_card_number').val(),
        "verification_value": $('#credit_card_verification_value').val(),
        "month": $('#credit_card_exp').val().split("/")[0].trim(),
        "year": $('#credit_card_exp').val().split("/")[1].trim()
      }
      Spreedly.add_payment_method(card);
    }
  });
});

Spreedly = {
  add_payment_method: function(card) {
    var paramStr = $.param(card);
    var url = Spreedly.host + "?" + paramStr

    $.ajax({
      type: "GET",
      url: url,
      dataType: "jsonp",
      success: Spreedly.handleToken,
      error: Spreedly.handleTransmissionError
    });
  },
  handleToken: function(data) {
    Validator.reset();
    console.log(data);
    if (data.status === 201) {
      $.ajax({
        type: 'POST',
        url: '/book',
        data: {
          payment_method_token: data.transaction.payment_method.token,
          rooms: $('#credit_card_number').val()
        },
        success: Spreedly.handleBookingResponse,
        error: function(data) { alert("Booking system unavailable.") },
        dataType: "json",
      });
    } else {
      Spreedly.displaySpreedlyValidationMessages(data.errors);
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

Booking = {
}