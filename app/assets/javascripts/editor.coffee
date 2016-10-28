document.addEventListener 'turbolinks:load', ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    help = null
    editor = new Markdown.Editor(converter, attr, help)
    editor.run()
