// By Rupert Russell
// 25 January 2023
// added ability to control the guideline weight & grescale
// also added saving as SVG file for plotting on AxiDraw MiniKit2 
// https://github.com/rupertrussell/Islamic_002
// MIT licence
// Not ellegant
// Not optimised but it does the job
// webpage with details of my progress at: http://www.rupert.id.au/processing/examples/projection/index.html

// I am wanting to reproduce this design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design#img-8
// http://wiki.roblox.com/index.php?title=Dot_product
// https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
// https://martin-thoma.com/how-to-check-if-two-line-segments-intersect/
// http://www.sunshine2k.de/coding/java/PointOnLine/PointOnLine.html#step5
// https://en.wikibooks.org/wiki/Linear_Algebra/Orthogonal_Projection_Onto_a_Line
// Cite this chapter as: Bonner J. (2017) 3 Polygonal Design Methodology. In: Islamic Geometric Patterns. Springer, New York, NY
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=61ACU_ALMA51128361450002352&context=L&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_proquest1688306298&context=PC&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US
// https://github.com/postspectacular/toxiclibs/tree/master/examples/core/geometry
// http://haptic-data.com/toxiclibsjs/examples/circle-tangent-point
// http://haptic-data.com/toxiclibsjs/examples/line2d-intersection
// http://haptic-data.com/toxiclibsjs/
// http://toxiclibs.org/docs/core/toxi/geom/Vec2D.html
// http://natureofcode.com/book/chapter-1-vectors/

import processing.svg.*;

boolean test = false;
boolean drawCross = true;
boolean drawStar = true;
boolean drawCorners = true;

boolean drawEllipses = false; // draw the guideline ellipses
boolean drawArc = true;
boolean drawGuideLines = true;

int designColour = 0;
float designWeight = 1; // strokeWeight for the design
int dR = 0, dG = 0, dB = 200; // RGB vlause for the design

float[] innerX; // store xPoints for the 24 points on the inner circle
float[] innerY; // store yPoints for the 24 points on the inner circle
float[] outerX; // store xPoints for the 12 points on the outer circle
float[] outerY; // store yPoints for the 12 points on the outer circle
float[] outerMostX; // store xPoints for the 12 points on the outer circle
float[] outerMostY; // store yPoints for the 12 points on the outer circle
float[] starOneX;
float[] starOneY;
float[] starTwoX;
float[] starTwoY;
float testY = 0.3882;
int counter = 0;
int x1 =0;
int x2 = 250;
int y1 = 500;
int y2 = 250;
int deltaX = x1 -x2;
int deltaY = y1 - y2;
int x3;
int x4;

float scale = 500 ; // scale of bounding square
float xCenter = 600/2;
float yCenter = 600/2;
float start = radians(0);
float stop = radians(0);

float guideWeight = 0.5; // weight of guide lines 
int guideColour = 200; // greyscale vlaue of guide lines
int ellipseSize = 10;

void setup() {
  size(600, 600); // width x height
  // size(6000, 6000); // width x height test case
  noFill();
  innerX = new float[25]; // store x Points for the 24 points on the inner circle
  innerY = new float[25]; // store y Points for the 24 points on the inner circle
  outerX = new float[13]; // store x Points for the 12 points on the outer circle
  outerY = new float[13]; // store y Points for the 12 points on the outer circle
  outerMostX = new float[13]; // store x Points for the 12 points on the outermost circle which intersects with the boundary square
  outerMostY = new float[13]; // store y Points for the 12 points on the outermost circle which intersects with the boundary square
  starOneX = new float[25]; // store x Points for the 8 points on the inside of the star
  starOneY = new float[25]; // store y Points for the 8 points on the inside of the star
  starTwoX = new float[25]; // store x Points for the 24 points on the outside of the star on the endge of the square
  starTwoY = new float[25]; // store y Points for the 24 points on the outside of the star on the endge of the square
  beginRecord(SVG, "islamic_002_38_1_design_only.svg"); // Saves to a SGV file uncomment endrecord at bottom of code as well.
}

void draw() {
  drawCross = true;
  drawStar = true;
  drawCorners = true;
  drawGuideLines = false;
  drawArc = false;
  drawEllipses = true;

  background(255);
  noLoop();
  if (test == true) {
    // noLoop();
    scale = 500 * 10; // scale of bounding square
    xCenter = 600/2 * 10;
    yCenter = 600/2 * 10;
  }

  stroke(guideColour);  // set the grescale colour for the guidelies
  rectMode(CENTER);

  guides();
  drawTheCross();

  // Inner rotated Squares
  stroke(guideColour);
  if (drawEllipses) {
    // point 1
    ellipse(xCenter - scale * 0.1691, yCenter - scale * 0.5, ellipseSize, ellipseSize);  // top Left 
    // point 5
    ellipse(xCenter - scale * 0.5, yCenter - scale * 0.1691, ellipseSize, ellipseSize);  // Left top
    // point 6
    ellipse(xCenter - scale * 0.5, yCenter + scale * 0.1691, ellipseSize, ellipseSize);  // Left bottom
    // point 16
    ellipse(xCenter + scale * 0.5, yCenter - scale * 0.1691, ellipseSize, ellipseSize);  // Right top
    // point 15
    ellipse(xCenter + scale * 0.5, yCenter + scale * 0.1691, ellipseSize, ellipseSize);  // Right bottom
    // point 20
    ellipse(xCenter + scale * 0.1691, yCenter - scale * 0.5, ellipseSize, ellipseSize);  // bottom Left 
    // point 10
    ellipse(xCenter - scale * 0.1691, yCenter + scale * 0.5, ellipseSize, ellipseSize);  // top Right 
    // point 11
    ellipse(xCenter + scale * 0.1691, yCenter + scale * 0.5, ellipseSize, ellipseSize);  // bottom Right
  }

  if (drawGuideLines) {
    strokeWeight(guideWeight);
    stroke(guideColour);

    // First inner rotated square
    line(xCenter - scale * 0.5, yCenter - scale * 0.1691, xCenter + scale * 0.1691, yCenter - scale * 0.5); // top right left top
    line(xCenter - scale * 0.5, yCenter - scale * 0.169, xCenter - scale * 0.1691, yCenter + scale * 0.5); // top left to bottom left
    line(xCenter - scale * 0.1691, yCenter + scale * 0.5, xCenter + scale * 0.5, yCenter + scale * 0.1691); // bottom left to right bottom
    line(xCenter + scale * 0.5, yCenter + scale * 0.1691, xCenter + scale * 0.1691, yCenter - scale * 0.5 ); // right bottom to top right
    // Second inner rotated square
    line(xCenter - scale * 0.1691, yCenter - scale * 0.5, xCenter + scale * 0.5, yCenter - scale * 0.1691); // top right left top
    line(xCenter + scale * 0.5, yCenter - scale * 0.1691, xCenter + scale * 0.1691, yCenter + scale * 0.5); // top left to bottom left
    line(xCenter + scale * 0.1691, yCenter + scale * 0.5, xCenter - scale * 0.5, yCenter + scale * 0.1691); // bottom left to right bottom
    line(xCenter - scale * 0.5, yCenter + scale * 0.1691, xCenter - scale * 0.1691, yCenter - scale * 0.5); // right bottom to top right

    // moved lines
    line(xCenter - scale * 0.5, yCenter + scale * testY, xCenter + scale * 0.5, yCenter + scale * testY);
    line(xCenter - scale * testY, yCenter - scale * 0.5, xCenter - scale * testY, yCenter + scale * 0.5 );
    line(xCenter + scale * testY, yCenter - scale * 0.5, xCenter + scale * testY, yCenter + scale * 0.5 );
    // bottom line
    // line(xCenter - scale * 0.5, yCenter - scale * testY, xCenter + scale * 0.5, yCenter - scale * testY);

    // draw Inner non rotated square guides
    // the 8 ellipses
    // top line
    // point 2
    if (drawEllipses) {
      ellipse(xCenter - scale * 0.22435, yCenter - scale * testY, ellipseSize, ellipseSize);  // top Left
      // point 19
      ellipse(xCenter + scale * 0.22435, yCenter - scale * testY, ellipseSize, ellipseSize);  // top Right
      // point 9
      ellipse(xCenter - scale * 0.22435, yCenter + scale * testY, ellipseSize, ellipseSize);  // bottom Left
      // point `12
      ellipse(xCenter + scale * 0.22435, yCenter + scale * testY, ellipseSize, ellipseSize);  // bottom Right 
      // point 4
      ellipse(xCenter - scale * testY, yCenter - scale * 0.22435, ellipseSize, ellipseSize);  //  Left  top
      // point 7
      ellipse(xCenter - scale * testY, yCenter + scale * 0.22435, ellipseSize, ellipseSize);  // left bottom 
      // point 17
      ellipse(xCenter + scale * testY, yCenter - scale * 0.22435, ellipseSize, ellipseSize);  // right  top
      // point 14
      ellipse(xCenter + scale * testY, yCenter + scale * 0.22435, ellipseSize, ellipseSize);  //  right bottom 
      // point 3
      ellipse(xCenter - scale * testY, yCenter - scale * testY, ellipseSize, ellipseSize);  // top Left inner square crossing point
      // point 18
      ellipse(xCenter + scale * testY, yCenter - scale * testY, ellipseSize, ellipseSize);  // top Right inner square crossing point
      // point 8
      ellipse(xCenter - scale * testY, yCenter + scale * testY, ellipseSize, ellipseSize);  // Bottom Left inner square crossing point
      // point 13
      ellipse(xCenter + scale * testY, yCenter + scale * testY, ellipseSize, ellipseSize);  // Bottom Right inner square crossing point
    }
  }


  // draw corner angles
  if (drawCorners) {
    stroke(dR, dG, dB);
    strokeWeight(designWeight);
    // top left corner
    // 1 - 2  
    // code line 155
    line(xCenter - scale * 0.1691, yCenter - scale * 0.5, xCenter - scale * 0.22435, yCenter - scale * testY); // start point top left boundary square
    // 2 - 3
    line(xCenter - scale * 0.22435, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * testY); // working downwards and leftwards
    // 3 - 4
    line(xCenter - scale * testY, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * 0.22435);
    // 4 - 5
    line(xCenter - scale * testY, yCenter - scale * 0.22435, xCenter - scale * 0.5, yCenter - scale * 0.1691);
    // bottom left corner
    // 6 - 7  
    line(xCenter - scale * 0.5, yCenter + scale * 0.1691, xCenter - scale * testY, yCenter + scale * 0.22435); // start point bottom left boundary square
    // 7 - 8
    line(xCenter - scale * testY, yCenter + scale * 0.22435, xCenter - scale * testY, yCenter + scale * testY); // working downwards and rightwards
    // 8 - 9
    line(xCenter - scale * testY, yCenter + scale * testY, xCenter - scale * 0.22435, yCenter + scale * testY);
    // 9 - 10
    line(xCenter - scale * 0.22435, yCenter + scale * testY, xCenter - scale * 0.1691, yCenter + scale * 0.5);

    // bottom right corner
    // 11-12
    line(xCenter + scale * 0.1691, yCenter + scale * 0.5, xCenter + scale * 0.22435, yCenter + scale * testY);
    // 12 - 13
    line(xCenter + scale * 0.22435, yCenter + scale * testY, xCenter + scale * testY, yCenter + scale * testY);
    // 13 - 14
    line(xCenter + scale * testY, yCenter + scale * testY, xCenter + scale * testY, yCenter + scale * 0.22435);
    // 14 - 15
    line(xCenter + scale * testY, yCenter + scale * 0.22435, xCenter + scale * 0.5, yCenter + scale * 0.1691);
    // top right corner
    // 16 - 17
    line(xCenter + scale * 0.5, yCenter - scale * 0.1691, xCenter + scale * testY, yCenter - scale * 0.22435);
    // 17 - 18
    line(xCenter + scale * testY, yCenter - scale * 0.22435, xCenter + scale * testY, yCenter - scale * testY);
    // 18 - 19
    line(xCenter + scale * testY, yCenter - scale * testY, xCenter + scale * 0.22435, yCenter - scale * testY);
    // 19 - 20
    line(xCenter + scale * 0.22435, yCenter - scale * testY, xCenter + scale * 0.1691, yCenter - scale * 0.5);
  }

  // Star Two Guidelines **
  // calculate 24 points around the starTwo circle
  counter = 0;
  double step = radians(360/24);
  float h = xCenter; 
  float k = yCenter;
  float r = scale * 0.293 / 2; 
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    starTwoX[counter] = x;
    starTwoY[counter] = y;
    if (drawEllipses) {
      stroke(guideColour);
      ellipse(x, y, ellipseSize, ellipseSize);
    }
    //stroke(0);
    counter ++;
    if (counter ==25) {
      counter = 0;
    }
  } // end Star Two Guidelines **

  // determine Star Poinits
  starOneX[1] = xCenter - scale * 0.4081;
  starOneY[1] = yCenter - scale * 0.5;
  starOneX[2] = starTwoX[11];
  starOneY[2] = starTwoY[11];
  starOneX[3] = xCenter - scale * 0.5;
  starOneY[3] = yCenter + scale * 0.1691;
  starOneX[4] = xCenter - scale * 0.5;
  starOneY[4] = yCenter + scale * 0.4081;
  starOneX[5] = starTwoX[17];
  starOneY[5] = starTwoY[17];
  starOneX[6] = xCenter + scale * 0.1691;
  starOneY[6] = yCenter + scale * 0.5;
  starOneX[7] = xCenter + scale * 0.4081;
  starOneY[7] = yCenter + scale * 0.5;
  starOneX[8] = starTwoX[23];
  starOneY[8] = starTwoY[23];
  starOneX[9] = xCenter + scale * 0.5;
  starOneY[9] = yCenter - scale * 0.1691;
  starOneX[10] = xCenter + scale * 0.5;
  starOneY[10] = yCenter - scale * 0.4081;
  starOneX[11] = starTwoX[5];
  starOneY[11] = starTwoY[5];
  starOneX[12] = xCenter - scale * 0.1691; 
  starOneY[12] = yCenter - scale * 0.5;
  starOneX[13] =  xCenter + scale * 0.1691;
  starOneY[13] =  yCenter - scale * 0.5;
  starOneX[14] = starTwoX[7];
  starOneY[14] = starTwoY[7];
  starOneX[15] = xCenter - scale * 0.5;
  starOneY[15] = yCenter - scale * 0.4081;
  starOneX[16] = xCenter - scale * 0.5;
  starOneY[16] = yCenter - scale * 0.1691;
  starOneX[17] = starTwoX[13];
  starOneY[17] = starTwoY[13];
  starOneX[18] = xCenter - scale * 0.4081;
  starOneY[18] = yCenter + scale * 0.5;
  starOneX[19] = xCenter - scale * 0.1691; 
  starOneY[19] = yCenter + scale * 0.5;
  starOneX[20] =  starTwoX[19];
  starOneY[20] =  starTwoY[19];
  starOneX[21] = xCenter + scale * 0.5;
  starOneY[21] = yCenter + scale * 0.4081;
  starOneX[22] =  xCenter + scale * 0.5;
  starOneY[22] =  yCenter + scale * 0.1691;
  starOneX[23] =  starTwoX[1];
  starOneY[23] =  starTwoY[1];
  starOneX[24] = xCenter + scale * 0.4081;
  starOneY[24] = yCenter - scale * 0.5;

  // Star Lines
  if (drawStar) {
    strokeWeight(designWeight);
    stroke(dR, dG, dB);
    line(starOneX[1], starOneY[1], starOneX[2], starOneY[2]);
    line(starOneX[2], starOneY[2], starOneX[3], starOneY[3]);
    line(starOneX[4], starOneY[4], starOneX[5], starOneY[5]);
    line(starOneX[5], starOneY[5], starOneX[6], starOneY[6]);
    line(starOneX[7], starOneY[7], starOneX[8], starOneY[8]);
    line(starOneX[8], starOneY[8], starOneX[9], starOneY[9]);
    line(starOneX[10], starOneY[10], starOneX[11], starOneY[11]);
    line(starOneX[11], starOneY[11], starOneX[12], starOneY[12]);
    line(starOneX[13], starOneY[13], starOneX[14], starOneY[14]);
    line(starOneX[14], starOneY[14], starOneX[15], starOneY[15]);
    line(starOneX[16], starOneY[16], starOneX[17], starOneY[17]);
    line(starOneX[17], starOneY[17], starOneX[18], starOneY[18]);
    line(starOneX[19], starOneY[19], starOneX[20], starOneY[20]);
    line(starOneX[20], starOneY[20], starOneX[21], starOneY[21]);
    line(starOneX[22], starOneY[22], starOneX[23], starOneY[23]);
    line(starOneX[23], starOneY[23], starOneX[24], starOneY[24]);
  }

  if (test == true) {
    save("Islamic_002_38_1.png");
    // exit();
  }
  endRecord();  // Save the SVG file
}

void mousePressed() {
  background(0);
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
    save("Islamic_002_38_1.png");
    exit();
  }
}
void guides() {  
  strokeWeight(guideWeight);
  stroke(guideColour);
  if (drawGuideLines) {
    rect(xCenter, yCenter, scale, scale);  // draw the boundray square
    // outer circle used to determine points on boundary square
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    ellipse(xCenter, yCenter, scale * 1.154, scale * 1.154);  // draw the central circle in the square
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    ellipse(xCenter, yCenter, scale, scale);  // draw the central circle in the square
    ellipse(xCenter, yCenter, scale * 0.414, scale * 0.414);  // draw the iner central circle in the square
    point(xCenter, yCenter);
    line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line
    line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line
  }
  if (drawArc) {
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
  }
  // calculate 12 points around the outer circle
  counter = 0;
  double step = radians(360/12); 
  float h = xCenter; 
  float k = yCenter;
  float r =  scale /2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    // println("counter = " + counter);
    outerX[counter] = x;
    outerY[counter] = y;

    if (drawEllipses) {
      // fill(255, 100, 100);
      ellipse(x, y, ellipseSize, ellipseSize);  //  draw the 24 points 
      noFill();
    }
    if (drawGuideLines) {
      line(xCenter, yCenter, x, y);
    }
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }
  // ----------------------
  // draw the guidelines for the top bottom left and right ends of the cross
  if (drawGuideLines) {
    line(outerX[2], outerY[2], outerX[3], outerY[3]); // right verticle line of cross
    line(outerX[3], outerY[3], outerX[4], outerY[4]); // right verticle line of cross
    line(outerX[5], outerY[5], outerX[6], outerY[6]); // right verticle line of cross
    line(outerX[6], outerY[6], outerX[7], outerY[7]); // right verticle line of cross
    line(outerX[8], outerY[8], outerX[9], outerY[9]);   // right verticle line of cross
    line(outerX[9], outerY[9], outerX[10], outerY[10]); // right verticle line of cross
    line(outerX[11], outerY[11], outerX[12], outerY[12]); // right verticle line of cross
    line(outerX[12], outerY[12], outerX[1], outerY[1]);   // right verticle line of cross
  }
  // calculate 24 points around the inner circle
  step = radians(360/24);
  h = xCenter; 
  k = yCenter;
  r = scale * 0.414 / 2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta); 
    innerX[counter] = x;
    innerY[counter] = y;
    if (drawEllipses) {
      // fill(255, 100, 100);
      ellipse(x, y, ellipseSize, ellipseSize);  //  draw the 24 points 
      noFill();
    }
    counter ++;
    if (counter ==25) {
      counter = 0;
    }
  }
  // ----------------------
  // calculate 12 points around the outermost circle
  if (drawGuideLines) {
    noFill();
    counter = 0;
    step = radians(360/12); 
    h = xCenter; 
    k = yCenter;
    r =  scale * 1.154 / 2;
    ellipse(xCenter, yCenter, r * 2, r * 2);  // draw the outermost  circle
    for (float theta=0; theta < 2 * PI; theta += step) {
      float x = h + r * cos(theta);
      float y = k - r * sin(theta);
      // println("counter = " + counter);
      outerMostX[counter] = x;
      outerMostY[counter] = y;
      // fill(255, 100, 100);
      if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
        line(xCenter, yCenter, x, y);
      }
      noFill();
      counter ++;
      if (counter ==13) {
        counter = 0;
      }
    }
  }
  //cross guidelines
  if (drawGuideLines) {
    line(innerX[4], yCenter + scale /2, innerX[4], yCenter - scale /2); // right verticle line of cross
    line(innerX[8], yCenter + scale /2, innerX[8], yCenter - scale /2); // left verticle line of cross
    line(xCenter + scale /2, innerY[10], xCenter - scale /2, innerY[10]); // top horizontal line of cross
    line(xCenter + scale /2, innerY[14], xCenter - scale /2, innerY[14]); // top horizontal line of cross
  }
  if (drawEllipses) {
    ellipse(innerX[4], innerY[2], ellipseSize, ellipseSize); // inner top right turning point of cross
    ellipse(innerX[8], innerY[2], ellipseSize, ellipseSize); // inner top left turning poinnt of cross
    ellipse(innerX[4], innerY[14], ellipseSize, ellipseSize); // inner bottom right turning point of cross
    ellipse(innerX[8], innerY[14], ellipseSize, ellipseSize); // inner bottom left turning poinnt of cross

    // Cross outer horizontal turning points
    ellipse(outerX[5] - scale * 0.0392, innerY[10], ellipseSize, ellipseSize); // top outer left turning poinnt of cross
    ellipse(outerX[5] - scale * 0.0392, innerY[14], ellipseSize, ellipseSize); // bottom outer left turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[10], ellipseSize, ellipseSize); // top outer right turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[14], ellipseSize, ellipseSize); // bottom outer right turning poinnt of cross
    // turning point for cross
    ellipse(xCenter - scale * 0.1036, yCenter - scale * 0.4723, ellipseSize, ellipseSize);  // top left 
    ellipse(xCenter - scale * 0.1036, yCenter + scale * 0.4723, ellipseSize, ellipseSize);  // bottom left
    ellipse(xCenter + scale * 0.1036, yCenter - scale * 0.4723, ellipseSize, ellipseSize);  // top right 
    ellipse(xCenter + scale * 0.1036, yCenter + scale * 0.4723, ellipseSize, ellipseSize);  // bottom right
  }

  stroke(guideColour);
  if (drawGuideLines) {
    rect(xCenter, yCenter, scale, scale);  // draw the boundray square
    line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line
    line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line
  }
  // outer circle used to determine points on boundary square
  if (drawEllipses) {

    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    ellipse(xCenter, yCenter, scale, scale);  // draw the central circle in the square
    ellipse(xCenter, yCenter, scale * 0.414, scale * 0.414);  // draw the iner central circle in the square
    point(xCenter, yCenter);
  }
  // calculate 12 points around the outer circle
  counter = 0;
  step = radians(360/12); 
  h = xCenter; 
  k = yCenter;
  r =  scale /2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    // println("counter = " + counter);
    outerX[counter] = x;
    outerY[counter] = y;
    //fill(255, 100, 100);
    if (drawEllipses) {
      ellipse(x, y, ellipseSize, ellipseSize);  //  draw the 24 points
    }
    noFill();
    if (drawGuideLines) {
      line(xCenter, yCenter, x, y);
    }
    noFill();
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }
  // ----------------------
  if (drawGuideLines) {
    // draw the guidelines for the top bottom left and right ends of the cross
    line(outerX[2], outerY[2], outerX[3], outerY[3]); // right verticle line of cross
    line(outerX[3], outerY[3], outerX[4], outerY[4]); // right verticle line of cross
    line(outerX[5], outerY[5], outerX[6], outerY[6]); // right verticle line of cross
    line(outerX[6], outerY[6], outerX[7], outerY[7]); // right verticle line of cross
    line(outerX[8], outerY[8], outerX[9], outerY[9]);   // right verticle line of cross
    line(outerX[9], outerY[9], outerX[10], outerY[10]); // right verticle line of cross
    line(outerX[11], outerY[11], outerX[12], outerY[12]); // right verticle line of cross
    line(outerX[12], outerY[12], outerX[1], outerY[1]);   // right verticle line of cross
  }
  // calculate 24 points around the inner circle
  step = radians(360/24);
  h = xCenter; 
  k = yCenter;
  r = scale * 0.414 / 2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    innerX[counter] = x;
    innerY[counter] = y;
    if (drawEllipses) {
      //fill(255, 100, 100);
      ellipse(x, y, ellipseSize, ellipseSize);  //  draw the 24 points 
      noFill();
    }
    counter ++;
    if (counter ==25) {
      counter = 0;
    }
  }
  // ----------------------
  // calculate 12 points around the outermost circle
  noFill();
  counter = 0;
  step = radians(360/12); 
  h = xCenter; 
  k = yCenter;
  r =  scale * 1.154 / 2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    // println("counter = " + counter);
    outerMostX[counter] = x;
    outerMostY[counter] = y;
    if (drawGuideLines) {
      if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
        line(xCenter, yCenter, x, y);
      }
    }
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }
  if (drawGuideLines) {
    // cross guidelines
    line(innerX[4], yCenter + scale /2, innerX[4], yCenter - scale /2); // right verticle line of cross
    line(innerX[8], yCenter + scale /2, innerX[8], yCenter - scale /2); // left verticle line of cross
    line(xCenter + scale /2, innerY[10], xCenter - scale /2, innerY[10]); // top horizontal line of cross
    line(xCenter + scale /2, innerY[14], xCenter - scale /2, innerY[14]); // top horizontal line of cross
  }
  if (drawEllipses) {
    ellipse(innerX[4], innerY[2], ellipseSize, ellipseSize); // inner top right turning point of cross
    ellipse(innerX[8], innerY[2], ellipseSize, ellipseSize); // inner top left turning poinnt of cross
    ellipse(innerX[4], innerY[14], ellipseSize, ellipseSize); // inner bottom right turning point of cross
    ellipse(innerX[8], innerY[14], ellipseSize, ellipseSize); // inner bottom left turning poinnt of cross
    // Cross outer horizontal turning points
    ellipse(outerX[5] - scale * 0.0392, innerY[10], ellipseSize, ellipseSize); // top outer left turning poinnt of cross
    ellipse(outerX[5] - scale * 0.0392, innerY[14], ellipseSize, ellipseSize); // bottom outer left turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[10], ellipseSize, ellipseSize); // top outer right turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[14], ellipseSize, ellipseSize); // bottom outer right turning poinnt of cross
    // turning point for cross
    ellipse(xCenter - scale * 0.1036, yCenter - scale * 0.4723, ellipseSize, ellipseSize);  // top left 
    ellipse(xCenter - scale * 0.1036, yCenter + scale * 0.4723, ellipseSize, ellipseSize);  // bottom left
    ellipse(xCenter + scale * 0.1036, yCenter - scale * 0.4723, ellipseSize, ellipseSize);  // top right 
    ellipse(xCenter + scale * 0.1036, yCenter + scale * 0.4723, ellipseSize, ellipseSize);  // bottom right
  }
}//  end void guides //


void drawTheCross() {

  if (drawCross) {
    // draw cross
    stroke(dR, dG, dB);
    strokeWeight(designWeight);
    // Top wing
    line(innerX[8], yCenter - scale * 0.4723, outerX[3], outerY[3]); // top left to center line
    line(outerX[3], outerY[3], xCenter + scale * 0.1036, yCenter - scale * 0.4723); // top center line to top right
    line(innerX[4], yCenter - scale * 0.4723, innerX[4], innerY[2]); // top right verticle line
    line(innerX[8], yCenter - scale * 0.4723, innerX[8], innerY[2]);  // top
    // bottom wing
    line(innerX[8], innerY[14], xCenter - scale * 0.1036, yCenter + scale * 0.4723);  // Bottom Left Vertical line
    line(xCenter - scale * 0.1036, yCenter + scale * 0.4723, innerX[18], outerY[9]);  // Bottom Left to center of cross
    line(innerX[18], outerY[9], xCenter + scale * 0.1036, yCenter + scale * 0.4723 );  //  center of cross to Bottom right
    line(xCenter + scale * 0.1036, yCenter + scale * 0.4723, innerX[4], innerY[14]  );  //  center of cross to Bottom right
    // left wing
    line(outerX[5] - scale * 0.0392, innerY[10], innerX[8], innerY[10]);  // Top Left Horizontal line
    line(outerX[5] - scale * 0.0392, innerY[10], outerX[6], outerY[6]);  // outer top Left to center of cross
    line( outerX[6], outerY[6], outerX[5] - scale * 0.0392, innerY[14]);  //  center of cross to Bottom right
    line( outerX[5] - scale * 0.0392, innerY[14], innerX[8], innerY[14]  );  //  center of cross to Bottom right
    // Right wing
    line(outerX[1] + scale * 0.0392, innerY[10], innerX[4], innerY[10]);  // Top Right Horizontal line
    line(outerX[0], outerY[0], outerX[11] + scale * 0.0392, innerY[10]);  // outer top Right to center of cross
    line(outerX[0], outerY[0], outerX[1] + scale * 0.0392, innerY[14]);  //  center of cross to Bottom right
    line(outerX[1] + scale * 0.0392, innerY[14], innerX[4], innerY[14]);  // Bottom Right  Horizontal line
  }
}
