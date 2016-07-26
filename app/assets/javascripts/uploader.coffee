$.set_file_rename = ->
  files = $('#uploader').plupload('getFiles')
  i = 0
  while i < files.length
    name = $('.file-file-name:eq(' + i + ')')
    ext = files[i].name.split('.').pop()
    rename = name.val() + '.' + ext
    files[i].name = rename
    i++
  return

$.set_file_name = (up) ->
  i = 0
  while i < up.files.length
    file = $('.plupload_content .plupload_file_name:eq(' + i + ')')
    name = up.files[i].name
    rename = name.substr(0, name.lastIndexOf('.')) || name
    file.append '<input class="file-file-name" type="text" name="name" placeholder="Введите имя файла" data-file-number="' + i + '" value="' + rename + '">'
    file.append '<input class="all-tags" type="text" name="all_tags" placeholder="Введите теги через запятую">'
    i++
  $.empty_fields()

$.set_multipart_params = (up, file) ->
  name = $('.file-file-name').first()
  tags = $('.all-tags').first()
  ext = file.name.split('.').pop()
  rename = name.val() + '.' + ext
  up.settings.multipart_params['file_file_name'] = rename
  up.settings.multipart_params['all_tags'] = tags.val()
  file.name = rename
  name.closest('.plupload_file_name').find('span').show()
  name.remove()
  tags.remove()

$.empty_fields = ->
  $('.plupload_file_name span').hide()
  $('.plupload_done .plupload_file_name span').show()
  $('.plupload_done .plupload_file_name input').remove()
  fields = $('.plupload_file_name .file-file-name')
  emptyFields = fields.filter(->
    $.trim(@value) == ''
  )
  if emptyFields.length == 0
    $('.plupload_start').removeClass('ui-state-disabled')
  else
    $('.plupload_start').addClass('ui-state-disabled')

$(document).on 'page:change', ->
  $('body').on 'keyup', '.file-file-name', (event) ->
    span = $(@).closest('.plupload_file_name').find('span')
    name = $(@).val()
    text = span.text()
    ext = text.split('.').pop()
    rename = name + '.' + ext
    span.text(rename)
    $.empty_fields()
    $.set_file_rename()

  $('body').on 'click', '.plupload_start', (event) ->
    $('#uploader').plupload('start')
