class ModalFormManager

  _this = undefined

  constructor: (modalSelector) ->
    _this = this
    this.$modal = $(modalSelector)
    this.$form = $('form', this.$modal)

    this.$form.on('ajax:success', ->
      _this.submitSuccess()
    ).on 'ajax:error', (e, xhr, status, error) ->
      _this.$form.append '<p>ERROR</p>'

  submitSuccess: ->
    console.log "ModalFormManager: submit success"
    return unless this.modalIsVisible
    $('.submit-idea', this.$modal).removeClass('hidden')
    $('.submit-success', this.$modal).removeClass('hidden')

  submitError: ->
    return unless this.modalIsVisible

  modalIsVisible: ->
    this.$modal.hasClass 'in'

window.ModalFormManager = ModalFormManager
