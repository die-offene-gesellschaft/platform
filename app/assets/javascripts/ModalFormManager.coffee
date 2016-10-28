class ModalFormManager

  _this = undefined

  constructor: ->
    _this = this
    this.$modal = undefined
    this.$form = undefined
    this.modelName = undefined

    $.ajaxSetup({
      dataType: 'json'
    })

  init: (modalSelector) ->
    $('form', $(modalSelector)).on('ajax:success', (a, b, c, data) ->
      _this.setReferences(data.responseJSON.model)
      _this.successfulSubmit()

    ).on 'ajax:error', (_, data) ->
      _this.setReferences(data.responseJSON.model)
      _this.renderFormErrors(data.responseJSON.errors)

  setReferences: (modelName) ->
    this.modelName = modelName
    this.$modal = $("#participate_#{this.modelName}")
    this.$form = $('form', this.$modal)

  successfulSubmit: (modelName) ->
    return unless this.modalIsVisible
    this.clearFormFields()

    $('.submit-form', this.$modal).addClass('hidden')
    $('.submit-success', this.$modal).removeClass('hidden')

  clearFormErrors: ->
    this.$form.find('.form-group').removeClass('has-error')
    this.$form.find('span.help-block').remove()

  clearFormFields: ->
    this.$form.find(':input')
              .not(':button, :submit, :reset, :hidden')
              .val('')
              .removeAttr('checked')
              .removeAttr('selected')

  renderFormErrors: (errors) ->
    return unless this.modalIsVisible
    this.clearFormErrors()

    $.each(errors, (field, messages) ->
      input = _this.$form.find('input, select, textarea').filter(->
        name = $(this).attr('name')
        if name
          name.match(new RegExp(_this.modelName + '\\[' + field + '\\(?'))
      )

      input.closest('.form-group').addClass('has-error')
      input.parent().append(
        '<span class="help-block">' + $.map(messages, (m) ->
          m.charAt(0).toUpperCase() + m.slice(1)
        ).join('<br />') + '</span>'
      )
    )

  modalIsVisible: ->
    this.$modal.hasClass 'in'

window.ModalFormManager = ModalFormManager
