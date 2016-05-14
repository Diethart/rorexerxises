$ ->
  $ document
    .on 'ajax:success', '#cards_check', (e, data, status, xhr) ->
      $(this).empty()
      $(xhr.responseText).appendTo(this)
