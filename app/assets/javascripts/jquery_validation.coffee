$(document).on 'page:update', ->
  $('.validate-form').validate
    debug: false
    rules:
      'user[password]': { required: true, minlength: 6 }
      'user[password_confirmation]': { required: true, equalTo: '#user_password' }

jQuery.extend jQuery.validator.messages,
    required: 'Обязательное поле'
    pattern: 'Неверный формат'
    email: 'Неверный формат'
    number: 'Пожалуйста, введите число'

$ ->
  $.validator.setDefaults
    errorElement: 'span'
    errorClass: 'help-block'
    highlight: (element, errorClass, validClass) ->
      $(element).addClass errorClass
      $(element).closest('.form-group').removeClass('has-success').addClass 'has-error'
      return
    unhighlight: (element, errorClass, validClass) ->
      $(element).removeClass errorClass
      $(element).closest('.form-group').removeClass('has-error').addClass 'has-success'
      return
    errorPlacement: (error, element) ->
      if element.parent('.input-group').length
        error.insertAfter element.parent()
      else if element.hasClass('select2')
        error.insertAfter(element.next('span'))
      else
        error.insertAfter element
      return
