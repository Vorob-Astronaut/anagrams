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
  });


$('#modalTitle').on('hidden.bs.modal', function (e) {
  window.history.back();
});

