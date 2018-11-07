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
//= require activestorage
//= require turbolinks
//= require_tree .

var readURL = function(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.profile-pic').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

var ready = function() {
  $("#show-filters").on('click', function(){
    $("#filters").slideToggle();
  });

  $(".auto_submit_item").on('change', function() {
    $(this).parents("form").submit();
  });


  $(".file-upload").on('change', function(){
    readURL(this);
  });

  $(".upload-button, #plus-icon").on('click', function() {
     $(".file-upload").click();
  });

  $("#changePass").click(function(){
    $(".new-pass-input").attr("disabled",!this.checked);
  });
};

$(function() {
  ready;
});

$(document).on('turbolinks:load', ready);

