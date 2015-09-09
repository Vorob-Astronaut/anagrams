  $(function() {
    $("#search_field").autocomplete({
      source: "/ac.json",
      minLength: 1
    });
  });
