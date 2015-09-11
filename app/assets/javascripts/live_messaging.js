var source = new EventSource("/message");
source.addEventListener('message', function(e){
  $("#livemessage").html('<li>' + e.data + '</li>');
});
