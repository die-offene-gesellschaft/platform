class InitialPopUp
  constructor: ->
    if !Cookies.get('initial-pop-up')
      Cookies.set('initial-pop-up', true)
      $('#initial-pop-up').modal('show')

window.InitialPopUp = InitialPopUp