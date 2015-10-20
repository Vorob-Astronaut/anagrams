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

  var previousUrl;

  // This is for handle the modal for titles
  $(document).on('click','.product a.btn-eye', function(event){
    previousUrl = window.location.pathname;

    var newUrl = $(this).attr('href');

    $('#modalTitle').modal({
      backdrop: false
    });

    window.history.pushState({}, null, newUrl);
  });
  //------------------------------------//

  $(document).ready( function(){
    setSidebarHeight();
  })

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

  $(document).on('click', '.navbar-collapse-button span.fa-bars', function(){
    if( !$('.menu-sidebar').hasClass('menu-collapsed') ){
      $('.menu-sidebar').addClass('menu-collapsed');
      $('.main-content').addClass('menu-collapsed');
      $('.breadcrumb').addClass('menu-collapsed');
    }else{
      $('.menu-sidebar').removeClass('menu-collapsed');
      $('.main-content').removeClass('menu-collapsed');
      $('.breadcrumb').removeClass('menu-collapsed');
    }
  });

  $(document).on('click', '.close-button-back', function(){
    $('#modalTitle').modal('hide');
    $('li.navbar-collapse-button').html('<span class="fa fa-bars"></span>');
  });

  $(document).on('hidden.bs.modal', '#modalTitle', function (e) {
    window.history.pushState({}, null, previousUrl);
    setSidebarHeight();
  });
});

function setSidebarHeight(){
  var height = $(window).height();

  $('.sidebarr').css({
    height: height - ($('.navbar-default').height() + $('.navbar-subnav').height()),
  });
}

