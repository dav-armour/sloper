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

// Used for displaying profile avatar once file has been selected
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
  // Used to slide down the filters section on listings index page
  $("#show-filters").on('click', function(){
    $("#filters").slideToggle();
  });

  // Used to submit form whenever someone changes page or limit
  $(".auto_submit_item").on('change', function() {
    $(this).parents("form").submit();
  });

  // Used for profile image loading
  $(".file-upload").on('change', function(){
    readURL(this);
  });

  // Used for activating file input when label is clicked
  $(".upload-button, #plus-icon").on('click', function() {
     $(".file-upload").click();
  });

  // Used when editing profile to toggle new password fields
  $("#changePass").click(function(){
    $(".new-pass-input").attr("disabled",!this.checked);
  });
};

$(function() {
  ready;
});

$(document).on('turbolinks:load', ready);

