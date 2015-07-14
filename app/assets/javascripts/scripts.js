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

// $(document).ready(function(){
//   $(".add-friend-link").on("click", "a", function(){
//     var reviewId = $(this).attr("data-review-id");
//     var voteValue = $(this).attr("data-vote-value");
//   $.ajax({
//     type: "PATCH",
//     url: "/reviews/" + reviewId,
//     data: { "vote_value" : voteValue },
//     dataType: "json",
//     success: function(reviewObject) {
//         $("#vote_score_" + reviewObject.review.id).html(reviewObject.total);
//     }
//     });
//   });
// });
