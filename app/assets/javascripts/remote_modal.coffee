$(document).on 'ajax:success', '.modal [data-remote="true"]', (_, data) ->
  $(this).parents('.modal-body')
    .html(data)
    .animate
      scrollTop: 0
      , 300