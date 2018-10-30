var font1, font2;
var  fontsize1 = 60;
var  fontsize2 = 40;

function preload() {
  // Ensure the .ttf or .otf font stored in the assets directory
  // is loaded before setup() and draw() are called
  font1 = loadFont('assets/fonts/NeueDisplay-Wide.otf');
  font2 = loadFont('assets/fonts/Neue-Regular.otf')
}

function setup() {
  createCanvas(window.innerWidth, window.innerHeight);

  // Set text characteristics
  textAlign(CENTER, CENTER);

  background(255, 0, 0);
}

function draw() {

  // Creating a shape that adjusts as per mouse movement
  noStroke();
  fill(255);
  ellipse (mouseX, mouseY, 100, 100);

  textAlign(CENTER);
  drawWords( width * .5, height *.25 );

}

function drawWords(x, y) {
  // The text() function needs three parameters:
  // the text to draw, the horizontal position,
  // and the vertical position
  fill(255, 0, 0);
    // Same color as the background so that the wipe can work.

  textFont(font1);
  textSize(fontsize1);
  text("PARSONS SCHOOL OF DESIGN", x, y);

  textFont(font2);
  textSize(fontsize2);
  text("Akshansh Chaudhary", x, y*2);

}


function mouseReleased () {
  background (255, 0, 0);
}