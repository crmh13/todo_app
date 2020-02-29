/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 3);
/******/ })
/************************************************************************/
/******/ ({

/***/ 3:
/*!**********************************************!*\
  !*** ./app/javascript/packs/common/tasks.js ***!
  \**********************************************/
/*! dynamic exports provided */
/*! all exports used */
/***/ (function(module, exports) {

//$(function({
//  $('.edit_detail').change(function(){
//    $(this).closest("form").submit();
//  });
//
//  $('#new_detail').submit(function() {
//    $value = $('#detail_content').val().replace(/\s/g, "")
//    if ($value === "") {
//      $('#hidden').show();
//      return false;
//    } else {
//      $('#hidden').hide();
//    }
//  });
//
//  const check_disabled = () => {
//    if ($('#task_scheduled_date').val() === "") {
//      $('#task_send_mail').prop('disabled', true);
//    } else {
//      $('#task_send_mail').prop('disabled', false);
//    }
//  }
//
//  check_disabled();
//
//  $('#task_scheduled_date').change(function() {
//    check_disabled();
//  });
//
//  $('#task_scheduled_date').change(function() {
//    const $dataval = $('#task_scheduled_date').val();
//    const today = new Date();
//    const schedule_date = new Date($dataval);
//    if (today.getDate() > schedule_date.getDate()) {
//      $('#hidden').show();
//    } else {
//      $('#hidden').hide();
//    }
//  });
//});

var test = function test() {
	console.log('test');
};

/***/ })

/******/ });
//# sourceMappingURL=tasks-c88711d33dc4d1a779f8.js.map