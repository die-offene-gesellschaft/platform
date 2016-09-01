class RowClick
  constructor: ->
    $('tr[data-href]').on 'click', ->
      location = $(this).data('href')
      Turbolinks.visit(location)

document.addEventListener 'turbolinks:load', ->
  window.rowClick = RowClick()
