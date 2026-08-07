document.querySelectorAll('.faq-q').forEach(function(b){
  b.addEventListener('click', function(){
    b.parentElement.classList.toggle('open');
  });
});

var menuToggle = document.getElementById('menuToggle');
var navLinks = document.getElementById('navLinks');
if (menuToggle && navLinks) {
  menuToggle.addEventListener('click', function(){
    var open = navLinks.classList.toggle('open');
    menuToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
  });
  navLinks.querySelectorAll('a').forEach(function(a){
    a.addEventListener('click', function(){
      navLinks.classList.remove('open');
      menuToggle.setAttribute('aria-expanded', 'false');
    });
  });
}
