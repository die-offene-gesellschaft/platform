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
    this.basePath = window.location.pathname + window.location.search

  setLocationHash: (hash) ->
    this.currentModalIdentifier = hash
    _this.basePath = window.location.pathname + window.location.search
    if history.pushState
      history.pushState(null, null, "#show(#{this.currentModalIdentifier})")
    else
      location.hash = "show(#{this.currentModalIdentifier})"
    this.stopAllPlayingVideosOnModalClose()
    this.removeModalIdFromLocationHashOnModalClose()

  removeModalIdFromLocationHashOnModalClose: ->
    $(this.currentModalIdentifier).on('hidden.bs.modal', ->
      _this.currentModalIdentifier = undefined
      if history.pushState
        history.pushState(null, null, _this.basePath)
      else
        location.hash = ''
    )

  stopAllPlayingVideosOnModalClose: ->
    $(this.currentModalIdentifier).on('hidden.bs.modal', (e) ->
      videoFrame = $(e.currentTarget).find('iframe')
      videoFrame.attr('src',videoFrame.attr('src'))
    )

  openModalFromUrl: ->
    unescapedHash = unescape(window.location.hash)
    regexSearchGroup = /.*show\((#[-\w]+)\).*/.exec(unescapedHash)
    if !regexSearchGroup
      window.initialPopUp = new window.InitialPopUp()
      return

    this.currentModalIdentifier = regexSearchGroup[1]
    $(this.currentModalIdentifier).modal()
    this.removeModalIdFromLocationHashOnModalClose()

window.ModalManager = ModalManager
