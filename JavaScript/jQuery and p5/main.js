// Slider for the main page

$(window).on("scroll", function() {
	var position = $("#begin").offset();

	if ($(window).scrollTop() > position.top - 80) {
		$("nav").addClass("active");
	} else {
		$("nav").removeClass("active");
	};
});


// JS for Image slider

{/* <script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script> */}