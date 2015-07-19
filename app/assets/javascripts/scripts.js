function smoothScroll() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') || location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
          if (target.length) {
            $('html,body').animate({
              scrollTop: target.offset().top
            }, 1000);
          return false;
        }
      }
  });
};

$(document).foundation();
$(".full-height").height($(".main").parent().height());

// $( ".flash" ).fadeOut( 3000, function() {
//     // Animation complete.
//   });

// $(document).ready(function(){
//   $(".add-friend-link").change(function(){
//     var search = $(this).attr("search");
//   $.ajax({
//     type: "GET",
//     url: "/friendships"
//     data: { "search" : search },
//     dataType: "json",
//     success: function() {
//         $("#vote_score_" + reviewObject.review.id).html(reviewObject.total);
//     }
//     });
//   });
// });
