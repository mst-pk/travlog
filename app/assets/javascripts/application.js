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
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
    $(function() {
        $(".hidden_field").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $("#travel-form-img").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
         $(".hidden_field-user-img").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $(".user-icon").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
         $(".hidden_field-user-back-img").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $(".user-background-img").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
         $(".hidden_field-event-img-0").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $(".event-form-img-0").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
        $(".hidden_field-event-img-1").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $(".event-form-img-1").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
        $(".hidden_field-event-img-2").change(function(e){
            var file = e.target.files[0];
            var reader = new FileReader();
            
            reader.onload = (function(file) {
                return function(e) {
                    $(".event-form-img-2").attr("src", e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
        
    });
});
