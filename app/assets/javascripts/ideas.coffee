class ModalFormManager

  _this = undefined

  constructor: (modalSelector) ->
    _this = this
    this.$modal = $(modalSelector)
    this.$form = $('form', this.$modal)
    this.modelName = this.$form.attr('id').substring(4)

    $.ajaxSetup({
      dataType: 'json'
    })

    this.$form.on('ajax:success', ->
      _this.submitSuccess()
    ).on 'ajax:error', (e, data, status, error) ->
      _this.clearFormErrors()
      _this.renderFormErrors(data.responseJSON)

  submitSuccess: ->
    console.log "ModalFormManager: submit success"
    return unless this.modalIsVisible
    $('.submit-idea', this.$modal).removeClass('hidden')
    $('.submit-success', this.$modal).removeClass('hidden')

  clearFormErrors: ->
    console.log "ModalFormManager: clearFormErrors"
    this.$form.find('.form-group').removeClass('has-error')
    this.$form.find('span.help-block').remove()

  renderFormErrors: (errors) ->
    console.log "ModalFormManager: renderFormErrors"
    return unless this.modalIsVisible
    this.clearFormErrors()

    $.each(errors, (field, messages) ->
      console.log field, messages
      # input = _this.$form.find('input, select, textarea').filter(->
      #   name = $(this).attr('name')
      #   if name
      #     name.match(new RegExp(_this.modelName + '\\[' + field + '\\(?'))
      # )
      # input.closest('.form-group').addClass('has-error')
      # input.parent().append('<span class="help-block">' + $.map(messages, (m) -> m.charAt(0).toUpperCase() + m.slice(1)).join('<br />') + '</span>')
    )

  modalIsVisible: ->
    this.$modal.hasClass 'in'

window.ModalFormManager = ModalFormManager
