'use strict';

window.jQuery = window.$ = require('jquery');

export default class ResizeManager {
  constructor() {
    this.$window = null;
    this.windowWidth = 0;
    this.windowHeight = 0;
    this.functions = [];
    this.length = 0;
    this.fps = 60;
    this.isRunning = false;
  }

  init() {
    this.$window = $(window);
    this.update();

    this.$window.on('resize orientationchange', () => {
      if (!this.isRunning) {
        this.isRunning = true;

        if (window.requestAnimationFrame) {
          window.requestAnimationFrame(() => {
            this.update();
          });
        } else {
          setTimeout(() => {
            this.update();
          }, 1000/this.fps);
        }
      }
    });
  }

  add(func) {
    this.functions.push(func);
    this.length = this.functions.length;
  }

  remove(func) {
    this.functions.splice(func, 1);
    this.length = this.functions.length;
  }

  update() {
    this.windowWidth = this.$window.width();
    this.windowHeight = this.$window.height();

    for (let i = 0; i < this.length; i++) {
      let func = this.functions[i];
      func();
    }

    this.isRunning = false;
  }
};