class FilterButton

  _this = undefined

  constructor: ->
    _this = this
    _this.base_path = $('.filter').data('base-path')

    $('.filter button').on 'click', ->
      $(this).toggleClass('active')
      _this.updateGetParams($(this).data('filter'), $(this).hasClass('active'))

  updateGetParams: (filter, state) ->
    query = window.location.search.substring(1)
    if query.includes "filter-#{filter}=#{!state}"
      query = query.replace("filter-#{filter}=#{!state}", "filter-#{filter}=#{state}")
    else
      if query == ''
        query = "filter-#{filter}=#{state}"
      else
        query = "#{query}&filter-#{filter}=#{state}"
    Turbolinks.visit "#{_this.base_path}?#{query}"

window.FilterButton = FilterButton
