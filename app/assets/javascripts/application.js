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