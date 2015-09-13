  $(function() {
    $("#search_field").autocomplete({
      source: "/ac.json",
      minLength: 1
    });
    $("#q_film_title_cont").autocomplete({
      source: "/ac.json",
      minLength: 1
    });
  });
