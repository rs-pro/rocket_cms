import './fonts';
import './layout';

import Turbolinks from "turbolinks";
Turbolinks.start()

import Rails from '@rails/ujs';
Rails.start();

import "./components";
import "./pages";

//import "analytics"
//import goal from "analytics"

//import axios from 'axios';
//document.addEventListener("turbolinks:load", function() {
  //axios.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  //axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
//});

