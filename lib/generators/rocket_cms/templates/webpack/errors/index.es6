import './index.sass';
import Cookies from 'js-cookie';
import template from './errors.pug';

const COOKIE_ERROR = {
  title: 'В вашем броузере отключены Cookies',
  link: 'https://yandex.ru/support/common/browsers-settings/browsers-cookies.xml',
  anchor: 'Включите их',
  message: 'чтобы зайти на сайт'
}

class Errors {
  show(error) {
    $('body').prepend(template(error));
  }

  checkCookie() {
    $(".no-js-error").remove()
    $(".no-js-script").remove()
    if (!Cookies.get('cookies_on')) {
      this.show(COOKIE_ERROR);
      console.error('cookies not supported');
    } else {
      //console.info('cookies supported');
    }
  }
}

export default Errors;

