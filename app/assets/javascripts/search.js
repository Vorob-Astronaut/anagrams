$(function() {
  $("#add_a_film").click(function() {
    $("#add_film_form").toggle();
  });


  $("#search_field").autocomplete({
    source: function (request, response) {
        $.ajax({
            url: "/ac.json",
            dataType: "json",
            data: request,
            success: function (data) {
                if (!data.length) { // expect [] or ""
                    response(["We don't have that film on the site yet. Would you like us to add it?"])
                } else {
                    console.log(data)
                    response(data);
                }
            }
        });
    },
    minLength: 1
  });
  $("#q_film_title_cont").autocomplete({
    source: "/ac.json",
    minLength: 1
  });

  // This is for handle the modal for titles
  $('.product > a').click( function(event){
    var newUrl = $(this).attr('href');

    window.history.pushState({}, null, newUrl);
  });

  $('#modalTitle .close').click(function (e) {
    window.history.back();
  });
  //------------------------------------//

  setSidebarHeight();

  $(window).resize( function(){
    setSidebarHeight();
  });

  // Script for shrink the top navbar
  $(window).scroll(function() {
    if ($(this).scrollTop() >= 100)
    {
      $('.navbar.navbar-default.navbar-inverse').addClass('small');
      $('.navbar-subnav').addClass('scrolled');

      if( !$('.menu-sidebar').hasClass('scrolled') ){
        var height = $('.sidebarr').outerHeight() + 30;

        $('.sidebarr').css({
          height: height,
        });

        $('.menu-sidebar').addClass('scrolled');
      }
    }
    if ($(this).scrollTop() === 0) {
      $('.navbar.navbar-default.navbar-inverse').removeClass('small');
      $('.navbar-subnav').removeClass('scrolled');
      $('.menu-sidebar').removeClass('scrolled');

      var height = $('.sidebarr').outerHeight() - 30;
      $('.sidebarr').css({
        height: height,
      });
    }
  });

  $('.navbar-collapse-button span').click( function(){
    if( !$('.menu-sidebar').hasClass('menu-collapsed') ){
      $('.menu-sidebar').addClass('menu-collapsed');
      $('.main-content').addClass('menu-collapsed');
      $('.breadcrumb').addClass('menu-collapsed');
    }else{
      $('.menu-sidebar').removeClass('menu-collapsed');
      $('.main-content').removeClass('menu-collapsed');
      $('.breadcrumb').removeClass('menu-collapsed');
    }
  })
});

function setSidebarHeight(){
  var height = $(window).height();

  $('.sidebarr').css({
    height: height - (90 + 55),
  });
}


$('#modalTitle').on('hidden.bs.modal', function (e) {
  window.history.back();
});

