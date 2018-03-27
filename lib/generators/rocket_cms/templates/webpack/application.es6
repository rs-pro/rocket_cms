import './fonts';
import './layout';

import Errors from 'errors';
import 'flash';

var errors = new Errors()
document.addEventListener("DOMContentLoaded", function(event) {
  errors.checkCookie();
});

import Turbolinks from "turbolinks";
Turbolinks.start()

import Rails from 'rails-ujs';
Rails.start();

import axios from 'axios';

import "./blocks";
import "./pages";

import "analytics"
//import goal from "analytics"

document.addEventListener("turbolinks:load", function() {
  axios.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
});

