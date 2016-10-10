class InitialPopUp
  constructor: ->
    popUpModal = $('#initial-pop-up')
    displayPopUp = popUpModal.find('.modal-title').text() != ""
    if !Cookies.get('initial-pop-up') and displayPopUp
      Cookies.set('initial-pop-up', true)
      popUpModal.modal('show')

window.InitialPopUp = InitialPopUp