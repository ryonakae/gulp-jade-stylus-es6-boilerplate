'use strict';

window.jQuery = window.$ = require('jquery');
import {mainResizeManager} from '../main';

export default class ScrollManager {
  constructor() {
    this.$window = null;
    this.scrollTop = 0;
    this.scrollBottom = 0;
    this.functions = [];
    this.length = 0;
    this.fps = 60;
    this.isRunning = false;
  }

  init() {
    this.$window = $(window);
    this.update();

    this.$window.on('scroll', () => {
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
    this.scrollTop = this.$window.scrollTop();
    this.scrollBottom = this.scrollTop + mainResizeManager.windowHeight;

    for (let i = 0; i < this.length; i++) {
      let func = this.functions[i];
      func();
    }

    this.isRunning = false;
  }
};