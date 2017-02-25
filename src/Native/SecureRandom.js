var _libreirc$elm_crypto$Native_SecureRandom = function() {
'use strict';


//
// Check `crypto.getRandomValues()` compatibility
//
function fallback() {
  function fail(_parameter) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      callback(
        _elm_lang$core$Native_Scheduler.fail(
          _libreirc$elm_crypto$Random_Secure$NoGetRandomValues
        )
      );
    });
  }

  return {
    getRandomInts: fail,
    getRandomInt: fail
  };
}

// TODO: Test it manually with IE 10
if (typeof window !== 'object') { return fallback(); }
var crypto = window.crypto || window.msCrypto;
if (typeof crypto !== 'object' || typeof crypto.getRandomValues !== 'function') { return fallback(); }


//
// Implementation
//
function makeFn(retrieve) {
  return function(count) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      var values;

      try {
        values = retrieve();
      } catch (err) {
        // An exception has been thrown
        var errorName, errorMessage;
        if (typeof err === 'object') {
          errorName = err.name || "";
          errorMessage = err.message || err.toString();
        } else {
          errorName = typeof err;
          errorMessage = err.toString();
        }

        callback(
          _elm_lang$core$Native_Scheduler.fail(
            A2(_libreirc$elm_crypto$Random_Secure$Exception, errorName, errorMessage)
          )
        );
        return;
      }

      callback(_elm_lang$core$Native_Scheduler.succeed(values));
    });
  };
}

var crypto = window.crypto || window.msCrypto;
return {
  getRandomInts: makeFn(function() { return crypto.getRandomValues(new Uint32Array(count)); }),
  getRandomInt: makeFn(function() { return crypto.getRandomValues(new Uint32Array(1))[0]; })
};


}();
