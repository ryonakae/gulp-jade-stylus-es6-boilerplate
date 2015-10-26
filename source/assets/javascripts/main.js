'use strict';

const $ = require('jquery');
const velocity = require('velocity');

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