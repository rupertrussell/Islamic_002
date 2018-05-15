// I am wanting to reproduce this design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design#img-8
// http://wiki.roblox.com/index.php?title=Dot_product

// http://www.sunshine2k.de/coding/java/PointOnLine/PointOnLine.html#step5
// https://en.wikibooks.org/wiki/Linear_Algebra/Orthogonal_Projection_Onto_a_Line
// Cite this chapter as: Bonner J. (2017) 3 Polygonal Design Methodology. In: Islamic Geometric Patterns. Springer, New York, NY
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=61ACU_ALMA51128361450002352&context=L&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_proquest1688306298&context=PC&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US




int x1 =0;
int x2 = 250;
int y1 = 500;
int y2 = 250;
int deltaX = x1 -x2;
int deltaY = y1 - y2;
int x3;
int x4;

float scale = 500; // scale of bounding square
float xCenter = 300;
float yCenter = 300;

float start = radians(0);
float stop = radians(0);

void setup() {
  noFill();

  size(600, 600); // width x height
}


void draw() {

  background(255);
  stroke(0);
  strokeWeight(2);


  rectMode(CENTER);

  rect(xCenter, yCenter, scale, scale);  // draw the boundray square 

  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  ellipse(xCenter, yCenter, scale, scale);  // draw the central circle in the square

  strokeWeight(1);
  ellipse(xCenter, yCenter, scale * 0.414, scale * 0.414);  // draw the iner central circle in the square


  point(xCenter, yCenter);

  strokeWeight(1);
  line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line

  line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line

  //  draw the 4 arcs using a circle centered on each corner
  start =   radians(0);
  stop =    radians(90);
  arc(xCenter - scale/2, yCenter - scale / 2, scale, scale, start, stop);

  start =   radians(90);
  stop =    radians(180);
  arc(xCenter + scale/2, yCenter - scale / 2, scale, scale, start, stop);

  start =   radians(180);
  stop =    radians(270);
  arc(xCenter + scale/2, yCenter + scale / 2, scale, scale, start, stop);

  start =   radians(270);
  stop =    radians(360);
  arc(xCenter - scale/2, yCenter + scale / 2, scale, scale, start, stop);


  // calculate 12 points around the outer circle
  double step = radians(360/12); // see note 1
  float h = xCenter; 
  float k = yCenter;
  float r =  scale /2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta); //note 2.
    fill(255, 0, 0);
    ellipse(x, y, 5, 5);
    line(xCenter, yCenter, x, y);
    noFill();
  }


  // calculate 24 points around the inner circle
   step = radians(360/24); // see note 1
   h = xCenter; 
   k = yCenter;
   r = scale * 0.414 / 2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta); //note 2.
    fill(255, 0, 0);
    ellipse(x, y, 5, 5);
   // line(xCenter, yCenter, x, y);
    noFill();
  }


}


void mousePressed() {
  scale = 200; // scale of bounding square
  xCenter = 150;
  yCenter = 150;
}

void mouseReleased() {
  scale = 500; // scale of bounding square
  xCenter = 300;
  yCenter = 300;
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("Islamic_002.png");
    exit();
  }
}
