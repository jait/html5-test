// Generated by CoffeeScript 1.10.0
(function() {
  var bindReady, domReady, isReady, log, onReady, readyBound, readyCallback, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  log = function(msg) {
    return typeof console !== "undefined" && console !== null ? console.log(msg) : void 0;
  };

  readyBound = false;

  isReady = false;

  readyCallback = void 0;

  domReady = function() {
    if (!isReady) {
      if (!document.body) {
        return setTimeout(domReady, 13);
      }
      if (document.removeEventListener != null) {
        document.removeEventListener("DOMContentLoaded", domReady, false);
      } else {
        window.removeEventListener("load", domReady, false);
      }
      isReady = true;
      if (typeof readyCallback === "function") {
        readyCallback(window, []);
      }
    }
  };

  bindReady = function() {
    if (readyBound) {
      return;
    }
    readyBound = true;
    if (document.readyState === "complete") {
      return domReady();
    } else {
      if (document.addEventListener != null) {
        document.addEventListener("DOMContentLoaded", domReady, false);
      }
      window.addEventListener("load", domReady, false);
    }
  };

  onReady = function(fn) {
    bindReady();
    if (isReady) {
      return fn != null ? fn.call(window, []) : void 0;
    } else {
      return readyCallback = fn;
    }
  };

  root.onReady = onReady;

}).call(this);
