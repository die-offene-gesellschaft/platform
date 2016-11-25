class SlideshowManager

  _this = undefined
  constructor: ->
    _this = this
    slides = $('.slideshow .slide')
    slides.removeClass('active')
    currentSlide = slides.first().addClass('active')
    setInterval(() ->
      currentSlide.removeClass('active')
      currentSlide = currentSlide.next('.slide').addClass('active')
      if currentSlide.length == 0
        currentSlide = slides.first().addClass('active')
     , 3000)

window.SlideshowManager = SlideshowManager
