class LazyLoadingManager

  _this = undefined

  constructor: ->
    _this = this

    # bind click handler to each modal-able element to save opened modal ID to location hash
    _this.bindMoreUsersButtonClick() 
  bindMoreUsersButtonClick: () ->
    $('.more-users').click (event) ->
      event.preventDefault()
      url = $(this).attr('href')
      that = this
      $.ajax({
        url: url
        cache: false
        success: (response) ->
          response = $(response)
          responseMoreUsersButton = response.find('.more-users')
          $(that).replaceWith(responseMoreUsersButton)
          _this.bindMoreUsersButtonClick()
          responseGrid = response.find('.grid')
          console.log(responseGrid)
          $('.grid').last().after(responseGrid)
          responseModalsContainer = response.find('.modals-container')
          console.log(responseModalsContainer)
          $('.modals-container').last().after(responseModalsContainer)
      })

window.LazyLoadingManager = LazyLoadingManager