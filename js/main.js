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

document.querySelectorAll('.cards').forEach(function(el){
  var isDown = false, startX, scrollLeft;
  el.addEventListener('mousedown', function(e){
    isDown = true;
    el.classList.add('dragging');
    startX = e.pageX - el.offsetLeft;
    scrollLeft = el.scrollLeft;
  });
  ['mouseleave', 'mouseup'].forEach(function(evt){
    el.addEventListener(evt, function(){
      isDown = false;
      el.classList.remove('dragging');
    });
  });
  el.addEventListener('mousemove', function(e){
    if (!isDown) return;
    e.preventDefault();
    var x = e.pageX - el.offsetLeft;
    var walk = x - startX;
    el.scrollLeft = scrollLeft - walk;
  });
});

(function cookieNotice(){
  var STORAGE_KEY = 'artex_cookie_notice_seen';
  var seen = null;
  try { seen = localStorage.getItem(STORAGE_KEY); } catch (e) {}
  if (seen) return;

  var banner = document.createElement('div');
  banner.className = 'cookie-banner';
  banner.id = 'cookieBanner';
  banner.innerHTML =
    '<div class="wrap cookie-banner-inner">' +
      '<p>Ta strona wykorzystuje pliki cookies, aby zapewnić jak najlepsze działanie serwisu. Dalsze korzystanie ze strony oznacza zgodę na ich użycie. Szczegóły znajdziesz w <a href="polityka-cookies.html">Polityce cookies</a>.</p>' +
      '<div class="cookie-banner-actions">' +
        '<button type="button" class="btn alt" id="cookieDecline">Odrzuć</button>' +
        '<button type="button" class="btn" id="cookieAccept">Akceptuję</button>' +
      '</div>' +
    '</div>';
  document.body.appendChild(banner);

  document.getElementById('cookieAccept').addEventListener('click', function(){
    try { localStorage.setItem(STORAGE_KEY, 'accepted'); } catch (e) {}
    banner.remove();
  });
  document.getElementById('cookieDecline').addEventListener('click', function(){
    try { localStorage.setItem(STORAGE_KEY, 'declined'); } catch (e) {}
    banner.remove();
  });
})();
