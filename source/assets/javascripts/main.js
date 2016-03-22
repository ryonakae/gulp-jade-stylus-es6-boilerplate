'use strict';

window.jQuery = window.$ = require('jquery');
const imagesLoaded = require('imagesloaded');
imagesLoaded.makeJQueryPlugin($);
const velocity = require('velocity-animate');

import ResizeManager from './modules/ResizeManager';
import ScrollManager from './modules/ScrollManager';
import GetUa from './modules/GetUa';
const resizeManager = new ResizeManager();
const scrollManager = new ScrollManager();
const getUa = new GetUa();

export const mainResizeManager = resizeManager;

(() => {
  $(() => {
    console.log('page loaded');

    getUa.init();

    resizeManager.add(resized01);
    resizeManager.add(resized02);
    resizeManager.init();

    scrollManager.add(scroll01);
    scrollManager.init();
  });

  const resized01 = () => {
    console.log('is resized! 01');
  };
  const resized02 = () => {
    console.log('is resized! 02');
  };
  const scroll01 = () => {
    console.log('is scrolled! 01');
  };
})();