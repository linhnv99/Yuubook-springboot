$(document).ready(function () {
     // menu scroll
	/*
	 * $(window).scroll(function () { if ($("html").scrollTop() >= 350) {
	 * $(".header-bottom").addClass("scroll-down"); } else {
	 * $(".header-bottom").removeClass("scroll-down"); } });
	 */
     
     var prevScrollpos = window.pageYOffset;
     window.onscroll = function () {
          var currentScrollPos = window.pageYOffset;
          if (prevScrollpos > currentScrollPos) {
               $(".header-bottom").addClass("scroll-down");
          } else {
               $(".header-bottom").removeClass("scroll-down");;
          }
          prevScrollpos = currentScrollPos;
     }
     
     $(window).scroll(function () {
          if ($("html").scrollTop() > 400) {
               $("#gototop").addClass('block');
          } else $("#gototop").removeClass('block');
     });

     $("#gototop").click(function (e) {
          e.preventDefault();
          $("html,body").animate({
               scrollTop: 0
          }, "slow")
     });

     // slider-top
     // xử lý nút next
     $(".next").click(function (e) {
          var nextBtn = $(".active").next();
          if (nextBtn.length == 0) {
               $('.slide.active').addClass('hide-to-left').one('webkitAnimationEnd', function () {
                    $(this).removeClass('hide-to-left').removeClass('active');
               });
               $('.slides .slide:first-child()').addClass('show-to-right').one('webkitAnimationEnd', function () {
                    $(this).addClass('active').removeClass('show-to-right');
               });
          } else {
               $('.slide.active').addClass('hide-to-left').one('webkitAnimationEnd', function () {
                    $(this).removeClass('hide-to-left').removeClass('active');
               });
               nextBtn.addClass('show-to-right').one('webkitAnimationEnd', function () {
                    $(this).addClass('active').removeClass('show-to-right');
               });
          }
     });
     // xử lý nút prev
     $(".prev").click(function (e) {
          var prevBtn = $(".active").prev();
          if (prevBtn.length == 0) {
               $('.slide.active').addClass('hide-to-right').one('webkitAnimationEnd', function () {
                    $(this).removeClass('hide-to-right').removeClass('active');
               });
               $('.slides .slide:last-child()').addClass('show-to-left').one('webkitAnimationEnd', function () {
                    $(this).addClass('active').removeClass('show-to-left');
               });
          } else {
               $('.slide.active').addClass('hide-to-right').one('webkitAnimationEnd', function () {
                    $(this).removeClass('hide-to-right').removeClass('active');
               });
               prevBtn.addClass('show-to-left').one('webkitAnimationEnd', function () {
                    $(this).addClass('active').removeClass('show-to-left');
               });
          }
     });

     var interval;
     function startSlider() {
          interval = setInterval(() => {
               $('.next').trigger("click");
          }, 4500);
     }
     function stopSlider() {
          clearInterval(interval);
     }
     $("#slider").mouseover(function () {
          console.log("over")
          stopSlider()
     });
     $("#slider").mouseout(function () {
          console.log("out");
          startSlider();
     });



     // login
     $("#login").click(function (e) { 
          e.preventDefault();
          $(".box-model").addClass("block");
     });
     $("#close-model").click(function (e) { 
          e.preventDefault();
          $(".box-model").removeClass("block");
     });

     // category
     $("#category > span").click(function () { 
          $("#category ul").toggleClass("block");
     });
     // slide img-book
     $("ul.slide-img-detail li:first-child").addClass("active");
     $("ul.slide-img-detail li img").click(function (e) { 
          e.preventDefault();
          $("ul.slide-img-detail li").removeClass("active");
          var imgActive = $(this).attr("src");
          $(".box-img-book .book-img img").attr("src", imgActive);
          $(this).parent().addClass("active");
     });
     
   // quantity
     var min = parseInt($(".number").attr("min"));
     var max = parseInt($(".number").attr("max"))
     $(".qtyplus").on("click", function () {
       oldVal = parseInt($(this).parent().find(".number").val());
       $(this).parent().find(".number").val(oldVal + 1);
       if (oldVal >= max) {
         alert("Bạn chỉ có thể mua tối đa 100 sản phẩm. Để mua hàng với số lượng lớn vui lòng liên hệ Hotline.");
         $($(this).parent().find(".number")).val(99);
         return false;
       }
     })

     $(".qtyminus").on("click", function () {
       oldVal = parseInt($(this).parent().find(".number").val());
       if (oldVal <= min) {
         var newVal = oldVal;
       } else {
         var newVal = oldVal - 1;
       }
       $($(this).parent().find(".number")).val(newVal);
     })

     $(".number").on("change", function () {
       val = parseInt($(this).val());
       if (val > max) {
         alert("Bạn chỉ có thể mua tối đa 100 sản phẩm. Để mua hàng với số lượng lớn vui lòng liên hệ Hotline.");
         $(this).val(99);
       }
       if (val <= min) {
         $(this).val(1);
       }
     })
     
     $(".rate-form .rate-now .star").on("click",function(){
    	$(this).prevAll().removeClass("selected")
 		$(this).nextAll().removeClass("selected")
		$(this).addClass("selected");
		$(this).addClass("active").prevAll().addClass("active");
		$(this).nextAll().removeClass("active")
     })
     
     
     $(".sort-by").on("click", function(){
          $(this).find(".sort-tmp").toggle();
     })
     $(".sort-by .sort-tmp a").on("click", function () {
          $(".sort-by .sort-tmp a").removeClass("active");
          $(this).addClass("active");
     })
     $(".sort-by .selected-sort").html($(".sort-by .sort-tmp").find("a.active").text())
});
