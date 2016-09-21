class RowClick
  constructor: ->
    $('tr[data-href]').on 'click', ->
      location = $(this).data('href')
      Turbolinks.visit(location)
    $('tr[data-modal]').on 'click', ->
      $modal = $('#' + $(this).data('modal'))
      $modal.modal('show')

document.addEventListener 'turbolinks:load', ->
  window.rowClick = RowClick()
