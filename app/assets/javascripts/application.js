// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  $('#open').click(function(e){
    e.stopPropagation();
    $('#open').hide();
    $('#close').show();
    $('.menu').addClass('active');
    $('#over').addClass('back-overlay');
  });

  $('#close').click(function(e) {
    $('#close').hide();
    $('#open').show();
    $('.menu').removeClass('active');
    $('#over').removeClass('back-overlay');
  });

  $('#over').click(function() {
    $('#close').hide();
    $('#open').show();
    $('.menu').removeClass('active');
    $('#over').removeClass('back-overlay');
  })

  $('.menu').click(function(e) {
    e.stopPropagation();
  });
});