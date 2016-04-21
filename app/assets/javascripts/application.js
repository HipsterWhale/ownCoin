//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap-sprockets
//= require_tree .

// Handling  
function softReload() {
    Turbolinks.enableTransitionCache(true);
    Turbolinks.visit(location.toString());
    Turbolinks.enableTransitionCache(false);
}
var moveTimeout;
$(document).on('ready page:load', function() {
    clearTimeout(moveTimeout);
    moveTimeout = setTimeout(softReload, 7000);
});
$(document).mousemove(function() {
    clearTimeout(moveTimeout);
    moveTimeout = setTimeout(softReload, 7000);
});
