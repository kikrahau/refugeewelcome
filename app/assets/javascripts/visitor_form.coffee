$ ->
  $('#zip').autocomplete
    source: '/city-districts/index'
  $('#visitor-form').on 'submit', (event) ->
    zip_param = $('#zip').val()
    if int_zip_param = parseInt(zip_param)
      if zip_param.length != 5 
        Validation.addError($('#zip'),'Postleitzahl muss 5 Zeichen haben')
        event.preventDefault();

@Validation =
  addError: (location,message) ->
    unless message == $(location).parent().next('.error').text()
      $(location).parent().next('.error').text( message )
      $(location).parent().next('.error').toggle()