class AvatarUploadButton

  _this = undefined

  constructor: ->
    _this = this

    $('.user_avatar input').on 'change', (e) ->
      fileName = e.target.value.split('\\').pop()
      _this.readURL(this)

  readURL: (input) ->
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        bgImage =  e.target.result
        $('.user_avatar label').css('background-image', "url('#{bgImage}')").text('')
      reader.readAsDataURL(input.files[0])

window.AvatarUploadButton = AvatarUploadButton
