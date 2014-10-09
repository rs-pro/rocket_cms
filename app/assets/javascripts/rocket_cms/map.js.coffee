window.ya_init = ->
  $('.ymap').not('.done').addClass('done').each ->
    $m = $(this)
    coord = [$m.data('lat'), $m.data('lon')]
    map = new ymaps.Map($m[0],
      center: coord
      zoom: 14,
      behaviors: ['default'] #, 'scrollZoom']
    )
    map.controls.add('zoomControl', { left: 5, top: 5 })
    obj = new ymaps.Placemark(coord,
      hintContent: $m.data('hint')
      balloonContent: $m.data('hint') + ' ' + $m.data('addr')
    )
    map.geoObjects.add obj

$(document).on 'page:change', ->
  return if $('.ymap').not('.done').length == 0
  if window.ymaps
    ya_init()
  else
    head.load "//api-maps.yandex.ru/2.0/?load=package.full&lang=ru-RU&onload=ya_init"