class SlideshowManager

  _this = undefined
  constructor: ->
    _this = this
    slides = $('.slideshow .slide')
    slides.removeClass('active')
    currentSlide = slides.first().addClass('active')
    $('.nav-block[slide="0"]').addClass('active')
    setInterval(() ->
      currentSlide.removeClass('active')
      $('.nav-block').removeClass('active')
      currentSlide = currentSlide.next('.slide').addClass('active')
      activeID = currentSlide.attr('slide')
      $('.nav-block[slide="'+activeID+'"]').addClass('active')
      if currentSlide.length == 0
        currentSlide = slides.first().addClass('active')
        $('.nav-block[slide="0"]').addClass('active')
     , 5000)

window.SlideshowManager = SlideshowManager
