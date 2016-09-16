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
      _this.setLocationHash($(this).data('target'))

  setLocationHash: (hash) ->
    this.currentModalIdentifier = hash
    window.location.hash = "show(#{this.currentModalIdentifier})"
    this.removeModalIdFromLocationHashOnModalClose()

  removeModalIdFromLocationHashOnModalClose: ->
    $(this.currentModalIdentifier).on('hidden.bs.modal', ->
      _this.currentModalIdentifier = undefined
      window.location.hash = window.location.hash.replace(/show\(#[-\w]+\)/, '')
    )

  openModalFromUrl: ->
    regexSearchGroup = /.*show\((#[-\w]+)\).*/.exec(window.location.hash)
    return unless regexSearchGroup

    this.currentModalIdentifier = regexSearchGroup[1]
    $(this.currentModalIdentifier).modal()
    this.removeModalIdFromLocationHashOnModalClose()

window.ModalManager = ModalManager
