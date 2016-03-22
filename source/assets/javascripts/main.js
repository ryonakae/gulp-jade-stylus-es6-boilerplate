'use strict';

window.jQuery = window.$ = require('jquery');
const imagesLoaded = require('imagesloaded');
imagesLoaded.makeJQueryPlugin($);
const velocity = require('velocity-animate');

import ResizeManager from './modules/resizeManager';
import GetUa from './modules/getUa';
const resizeManager = new ResizeManager();
const getUa = new GetUa();

(() => {
  $(() => {
    console.log('page loaded');

    resizeManager.add(resized01);
    resizeManager.add(resized02);
    resizeManager.init();

    getUa.init();
  });

  const resized01 = () => {
    console.log('is resized! 01');
  };
  const resized02 = () => {
    console.log('is resized! 02');
  };
})();