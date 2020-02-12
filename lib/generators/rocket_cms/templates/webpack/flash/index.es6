import './index.sass';

//document.addEventListener('DOMContentLoaded', function () {
document.addEventListener("turbolinks:load", function() {
  var close = document.querySelectorAll("a.close_flash");
  close.forEach(function(n) {
    n.addEventListener("click", function() {
      var msg = this.parentNode.parentNode;
      var box = msg.parentNode;
      this.parentNode.parentNode.remove();
      if (box.childNodes.length == 0) {
        box.remove()
      }
    })
  })
});
