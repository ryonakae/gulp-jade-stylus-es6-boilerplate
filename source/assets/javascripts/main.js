'use strict';

import JQuery from 'jquery';
window.jQuery = window.$ = JQuery;
import UAParser from 'ua-parser-js';

(() => {

  const parser = new UAParser();
  const ua = parser.getResult();

  class Greet {
    constructor(msg) {
      this.message = msg;
    }

    say() {
      return this.message;
    }
  }

  const greet = new Greet('Hello World!');
  console.log(greet.say());

  // ページ読み込み後の処理
  $(() => {
    console.log('page loaded');
  });

})();