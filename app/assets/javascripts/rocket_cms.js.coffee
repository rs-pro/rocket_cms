#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require head.load.js
#= require rocket_cms/map
#= require rocket_cms/flash

$(document).on 'page:change', ->
  $('input, textarea').placeholder()
