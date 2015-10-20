'use strict';

require('jquery');
require('velocity');

class Greet {
  constructor(msg) {
    this.message = msg;
  }

  say() {
    return this.message;
  }
}

var greet = new Greet('Hello World!');
console.log(greet.say());