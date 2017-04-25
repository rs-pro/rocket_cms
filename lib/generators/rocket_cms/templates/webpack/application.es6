//import 'font-awesome/css/font-awesome.css';
import 'application.sass';
import Errors from 'errors';
import 'flash';
//import 'bootstrap';

window.A = {}
A.errors = new Errors()
A.errors.checkCookie();

import Turbolinks from "turbolinks";
Turbolinks.start()

document.addEventListener("turbolinks:load", function() {
})

