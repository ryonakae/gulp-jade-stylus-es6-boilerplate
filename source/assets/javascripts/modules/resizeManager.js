'use strict';

window.jQuery = window.$ = require('jquery');

export default class ResizeManager {
  constructor() {
    this.windowWidth = 0;
    this.windowHeight = 0;
    this.functions = [];
    this.length = 0;
    this.resizeTimer = null;
  }

  init() {
    this.onResize();

    $(window).on('resize orientationchange', () => {
      clearTimeout(this.resizeTimer);

      this.resizeTimer = setTimeout(() => {
        this.onResize();
      }, 200);
    });
  }

  add(func) {
    this.functions.push(func);
    this.length = this.functions.length;
  }

  onResize() {
    this.windowWidth = $(window).width();
    this.windowHeight = $(window).height();

    for (let i = 0; i < this.length; i++) {
      let func = this.functions[i];
      func();
    }
  }
};