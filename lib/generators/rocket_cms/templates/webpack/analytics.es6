var old_url = window.location.href;

document.addEventListener("turbolinks:load", function() {
  //console.log("analytics load");

  if (window[metrika]) {
    window[metrika].hit(window.location.href, document.title, old_url)
  }
  old_url = window.location.href

  if (window.gtag) {
    gtag('event', 'page_view');
    //  gtag('event', 'page_view', { 'send_to': 'YOUR_ID_HERE' });
  }
});

export default function(name) {
  if (window[metrika] && window[metrika].reachGoal) {
    window[metrika].reachGoal(name);
  } else {
    if (window.console) {
      console.log('unable to send event - no metrika');
    }
  }

  //if (window.gtag) {
    //gtag('event', name);
  //}
};
