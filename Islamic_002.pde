// I am wanting to reproduce this design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design#img-8


// http://www.sunshine2k.de/coding/java/PointOnLine/PointOnLine.html#step5
// https://en.wikibooks.org/wiki/Linear_Algebra/Orthogonal_Projection_Onto_a_Line
// https://www.physicsforums.com/threads/projected-component-of-f-along-a-line-in-cartesian-question.735228/


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

  rect(xCenter, yCenter, scale, scale);  // Draw gray rect using CENTER mode

  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  ellipse(xCenter, yCenter, scale, scale);


  point(xCenter, yCenter);

  strokeWeight(1);
  line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line

  line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line

  start =   radians(0);
  stop =    radians(90);
  arc(xCenter - scale/2, yCenter - scale / 2, scale, scale, start, stop);

  start =   radians(90);
  stop =    radians(180);
  arc(xCenter + scale/2, yCenter - scale / 2, scale, scale, start, stop);

  start =   radians(180);
  stop =    radians(270);
  arc(xCenter + scale/2, yCenter + scale / 2, scale, scale, start, stop);

  stroke(255, 0, 0);
  strokeWeight(2);

  start =   radians(270);
  stop =    radians(360);
  arc(xCenter - scale/2, yCenter + scale / 2, scale, scale, start, stop);
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
