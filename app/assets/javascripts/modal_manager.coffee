class ModalManager

  _this = undefined

  constructor: ->
    _this = this
    this.currentModalIdentifier = undefined

    # open a modal if one is defined via url
    this.openModalFromUrl()

    # bind click handler to each modal-able element to save opened modal ID to location hash
    $('[data-toggle="modal"]').click (event) ->
      event.preventDefault()
      location = $(this).data('target')
      if location == undefined
        location = $(this).data('target_alt')
      _this.setLocationHash(location)

  setLocationHash: (hash) ->
    this.currentModalIdentifier = hash
    window.location.hash = "show(#{this.currentModalIdentifier})"
    this.removeModalIdFromLocationHashOnModalClose()

  removeModalIdFromLocationHashOnModalClose: ->
    $(this.currentModalIdentifier).on('hidden.bs.modal', ->
      _this.currentModalIdentifier = undefined
      window.location.hash = ' '
    )

  openModalFromUrl: ->
    regexSearchGroup = /.*show\((#[-\w]+)\).*/.exec(window.location.hash)
    if !regexSearchGroup
      window.initialPopUp = new window.InitialPopUp()
      return

    this.currentModalIdentifier = regexSearchGroup[1]
    $(this.currentModalIdentifier).modal()
    this.removeModalIdFromLocationHashOnModalClose()

window.ModalManager = ModalManager
