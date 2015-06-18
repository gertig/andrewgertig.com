//jQuery plugin that serializes a form in Rails type params
$.fn.serializeObject = function() {
  var values = {}
  $("form input, form select, form textarea").each( function(){
    values[this.name] = $(this).val();
  });

  return values;
}


//DOM is Ready
$(function(){

  //PUSHDOWN MESSAGES
  if ($(".flashy").length) {
     $(".close_me").live("click", function(){
       $(this).hide();
       $("div#messages").hide();
     });
     $("div#messages").slideDown();
     $("div#messages").delay(5000).slideUp();
  }

  $('#email-me').tooltip();
});



//DOM is Ready
$(function() {
  var countable_elem = document.getElementById("post_content"),
      results = {
        paragraphs: document.getElementById('result__paragraphs'),
        words: document.getElementById('result__words'),
        characters: document.getElementById('result__characters'),
        all: document.getElementById('result__all')
      };

  if (countable_elem) {
    new Countable(countable_elem, countableUpdater);
  }

  function countableUpdater(counter) {
    if ('textContent' in document.body) {
      results.paragraphs.textContent = counter.paragraphs;
      results.words.textContent = counter.words;
      // results.characters.textContent = counter.characters
      // results.all.textContent = counter.all
    } else {
      results.paragraphs.innerText = counter.paragraphs;
      results.words.innerText = counter.words;
      // results.characters.innerText = counter.characters
      // results.all.textContent = counter.all
    }
  };


  // Cloudinary uploads via Attachinary
  // $('.attachinary-input').attachinary();

});
