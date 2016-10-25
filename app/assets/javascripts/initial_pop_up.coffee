class InitialPopUp
  constructor: ->
    popUpModal = $('#initial-pop-up')
    displayPopUp = popUpModal.find('.modal-title').text() != ""
    if !Cookies.get('initial-pop-up') and displayPopUp
      Cookies.set('initial-pop-up', true,{ expires: 365 })
      popUpModal.modal('show')

window.InitialPopUp = InitialPopUp