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

// working on code line 185

boolean test = false;
boolean cross = true;
boolean drawEllipses = false;
boolean drawArc = true;

float[] innerX; // store xPoints for the 24 points on the inner circle
float[] innerY; // store yPoints for the 24 points on the inner circle

float[] outerX; // store xPoints for the 12 points on the outer circle
float[] outerY; // store yPoints for the 12 points on the outer circle

float[] outerMostX; // store xPoints for the 12 points on the outer circle
float[] outerMostY; // store yPoints for the 12 points on the outer circle

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

void setup() {
  size(600, 600); // width x height
  //size(6000, 6000); // width x height test case

  noFill();

  innerX = new float[25]; // store x Points for the 24 points on the inner circle
  innerY = new float[25]; // store y Points for the 24 points on the inner circle

  outerX = new float[13]; // store x Points for the 12 points on the outer circle
  outerY = new float[13]; // store y Points for the 12 points on the outer circle

  outerMostX = new float[13]; // store x Points for the 12 points on the outermost circle which intersects with the boundary square
  outerMostY = new float[13]; // store y Points for the 12 points on the outermost circle which intersects with the boundary square
}


void draw() {

  background(255);

  if (test == true) {
    noLoop();
    scale = 500 * 10; // scale of bounding square
    xCenter = 600/2 * 10;
    yCenter = 600/2 * 10;

    // Draw ruller
    stroke(255, 100, 100);
    strokeWeight(5);
    line(400, 400, 6000 - 400, 400); 

    for (int count = 0; count < 5400; count = count + 10) {      
      line(400 + count, 390, 400 + count, 410);
    }

    for (int count = 0; count < 5400; count = count + 50) {      
      line(400 + count, 360, 400 + count, 440);
    }

    strokeWeight(1);
    counter = 0;
    for (int count = 0; count < 5400; count = count + 100) {

      line(400 + count, 350, 400 + count, 450);

      if (counter == 20) {
        stroke(255, 0, 255);
        line(scale * 0.4964, 0, scale * 0.4964, 6000); // was 2479

        //ellipse(scale * 0.4964, scale * 0.1276, 8, 8); 
        //  println("scale / 2482 = "+ 2482 / scale);
        //  println("test = " + 2482 / scale);
      }

      counter ++;
    }
    strokeWeight(1);
  } else {
    //scale = 500 ; // scale of bounding square
    //xCenter = 600/2;
    //yCenter = 600/2;
  }

  stroke(200);
  strokeWeight(1);
  rectMode(CENTER);
  guides();

  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(30));
  translate(-width/2, -height/2);
  stroke(200);
  strokeWeight(1);
  simpleGuides();


  translate(width/2, height/2);
  rotate(radians(30));
  translate(-width/2, -height/2);
  stroke(200);
  strokeWeight(1);
  simpleGuides();
  popMatrix();

  // Inner rotated Squares
  stroke(200);

  // point 1
  // ellipse(xCenter - scale * 0.1691, yCenter - scale * 0.5, 20, 20);  // top Left 
  // point 5
  // ellipse(xCenter - scale * 0.5, yCenter - scale * 0.1691, 20, 20);  // Left top
  // point 6
  //  ellipse(xCenter - scale * 0.5, yCenter + scale * 0.1691, 20, 20);  // Left bottom
  // point 16
  // ellipse(xCenter + scale * 0.5, yCenter - scale * 0.1691, 20, 20);  // Right top
  // point 15
  // ellipse(xCenter + scale * 0.5, yCenter + scale * 0.1691, 20, 20);  // Right bottom
  // point 20
  // ellipse(xCenter + scale * 0.1691, yCenter - scale * 0.5, 20, 20);  // bottom Left 
  // point 10
  //ellipse(xCenter - scale * 0.1691, yCenter + scale * 0.5, 20, 20);  // top Right 
  // point 11
  // ellipse(xCenter + scale * 0.1691, yCenter + scale * 0.5, 20, 20);  // bottom Right 

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

  // draw Inner non rotated square guides
  // the 8 ellipses
  // top line

  // point 2
  // ellipse(xCenter - scale * 0.22435, yCenter - scale * testY, 20, 20);  // top Left 

  // point 19
  // ellipse(xCenter + scale * 0.22435, yCenter - scale * testY, 20, 20);  // top Right 
  line(xCenter - scale * 0.5, yCenter - scale * testY, xCenter + scale * 0.5, yCenter - scale * testY);
  noFill();

  // bottom line
  // point 9
  // ellipse(xCenter - scale * 0.22435, yCenter + scale * testY, 20, 20);  // bottom Left 

  // point `12
  // ellipse(xCenter + scale * 0.22435, yCenter + scale * testY, 20, 20);  // bottom Right 
  line(xCenter - scale * 0.5, yCenter + scale * testY, xCenter + scale * 0.5, yCenter + scale * testY);

  // left line
  // point 4
  // ellipse(xCenter - scale * testY, yCenter - scale * 0.22435, 20, 20);  //  Left  top

  // point 7
  // ellipse(xCenter - scale * testY, yCenter + scale * 0.22435, 20, 20);  // left bottom 
  line(xCenter - scale * testY, yCenter - scale * 0.5, xCenter - scale * testY, yCenter + scale * 0.5 );

  // Right line
  // point 17
  // ellipse(xCenter + scale * testY, yCenter - scale * 0.22435, 20, 20);  // right  top

  // point 14
  // ellipse(xCenter + scale * testY, yCenter + scale * 0.22435, 20, 20);  //  right bottom 
  line(xCenter + scale * testY, yCenter - scale * 0.5, xCenter + scale * testY, yCenter + scale * 0.5 );

  // top left inner square crossing point
  // point 3
  // ellipse(xCenter - scale * testY, yCenter - scale * testY, 20, 20);  // top Left inner square crossing point
  // point 18
  // ellipse(xCenter + scale * testY, yCenter - scale * testY, 20, 20);  // top Right inner square crossing point
  // point 8
  // ellipse(xCenter - scale * testY, yCenter + scale * testY, 20, 20);  // Bottom Left inner square crossing point
  // point 13
  // ellipse(xCenter + scale * testY, yCenter + scale * testY, 20, 20);  // Bottom Right inner square crossing point


  // draw corner angles
  stroke(255, 0, 0);
  strokeWeight(5);

  // top left corner
  // 1 - 2  
  // code line 155
  line(xCenter - scale * 0.1691, yCenter - scale * 0.5, xCenter - scale * 0.22435, yCenter - scale * testY); // start point top left boundary square
  // 2 - 3
  line(xCenter - scale * 0.22435, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * testY); // working downwards and leftwards
  // 3 - 4
  line(xCenter - scale * testY, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * 0.22435);
  // 4 - 5
  line(xCenter - scale * testY, yCenter - scale * 0.22435, xCenter - scale * 0.5, yCenter - scale * 0.1691 );

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

  if (test == true) {
    save("Islamic_002_27.png");
    exit();
  }
}


void mousePressed() {
  background(0);
  println("Mouse Pressed!!");
  scale = 200; // scale of bounding square
  xCenter = 150;
  yCenter = 150;
}

void mouseReleased() {
  scale = 500; // scale of bounding square
  xCenter = 300;
  yCenter = 300;
  println("Mouse Released");
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("Islamic_002_27.png");
    exit();
  }
}

void guides() {  
  strokeWeight(1);
  stroke(200);
  rect(xCenter, yCenter, scale, scale);  // draw the boundray square 

  // outer circle used to determine points on boundary square
  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  // ellipse(xCenter, yCenter, scale * 1.154, scale * 1.154);  // draw the central circle in the square

  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  ellipse(xCenter, yCenter, scale, scale);  // draw the central circle in the square

  ellipse(xCenter, yCenter, scale * 0.414, scale * 0.414);  // draw the iner central circle in the square
  point(xCenter, yCenter);


  line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line
  line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line

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

    fill(255, 100, 100);
    ellipse(x, y, 5, 5);  //  draw the 24 points 
    noFill();
    line(xCenter, yCenter, x, y);
    noFill();

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }

  // ----------------------

  // draw the guidelines for the top bottom left and right ends of the cross 

  line(outerX[2], outerY[2], outerX[3], outerY[3]); // right verticle line of cross
  line(outerX[3], outerY[3], outerX[4], outerY[4]); // right verticle line of cross

  line(outerX[5], outerY[5], outerX[6], outerY[6]); // right verticle line of cross
  line(outerX[6], outerY[6], outerX[7], outerY[7]); // right verticle line of cross

  line(outerX[8], outerY[8], outerX[9], outerY[9]);   // right verticle line of cross
  line(outerX[9], outerY[9], outerX[10], outerY[10]); // right verticle line of cross

  line(outerX[11], outerY[11], outerX[12], outerY[12]); // right verticle line of cross
  line(outerX[12], outerY[12], outerX[1], outerY[1]);   // right verticle line of cross

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
    fill(255, 100, 100);
    ellipse(x, y, 5, 5);  //  draw the 24 points 
    noFill();
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
  //stroke(255, 100, 100);
  //strokeWeight(2);
  //ellipse(xCenter, yCenter, r * 2, r * 2);  // draw the outermost  circle

  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);

    // println("counter = " + counter);
    outerMostX[counter] = x;
    outerMostY[counter] = y;

    fill(255, 100, 100);
    if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
      line(xCenter, yCenter, x, y);
    }
    noFill();
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }

  // cross guidelines
  line(innerX[4], yCenter + scale /2, innerX[4], yCenter - scale /2); // right verticle line of cross
  line(innerX[8], yCenter + scale /2, innerX[8], yCenter - scale /2); // left verticle line of cross
  line(xCenter + scale /2, innerY[10], xCenter - scale /2, innerY[10]); // top horizontal line of cross
  line(xCenter + scale /2, innerY[14], xCenter - scale /2, innerY[14]); // top horizontal line of cross

  if (drawEllipses) {

    ellipse(innerX[4], innerY[2], 15, 15); // inner top right turning point of cross
    ellipse(innerX[8], innerY[2], 15, 15); // inner top left turning poinnt of cross
    ellipse(innerX[4], innerY[14], 15, 15); // inner bottom right turning point of cross
    ellipse(innerX[8], innerY[14], 15, 15); // inner bottom left turning poinnt of cross


    // Cross outer horizontal turning points
    ellipse(outerX[5] - scale * 0.0392, innerY[10], 15, 15); // top outer left turning poinnt of cross
    ellipse(outerX[5] - scale * 0.0392, innerY[14], 15, 15); // bottom outer left turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[10], 15, 15); // top outer right turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[14], 15, 15); // bottom outer right turning poinnt of cross

    // turning point for cross
    ellipse(xCenter - scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top left 
    ellipse(xCenter - scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom left 

    ellipse(xCenter + scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top right 
    ellipse(xCenter + scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom right
  }


  if (cross) {
    // draw cross
    stroke(255, 100, 100);
    strokeWeight(4);
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
  strokeWeight(1);
  stroke(200);
  rect(xCenter, yCenter, scale, scale);  // draw the boundray square 

  // outer circle used to determine points on boundary square
  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  // ellipse(xCenter, yCenter, scale * 1.154, scale * 1.154);  // draw the central circle in the square

  strokeWeight(1);

  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  ellipse(xCenter, yCenter, scale, scale);  // draw the central circle in the square

  strokeWeight(1);
  ellipse(xCenter, yCenter, scale * 0.414, scale * 0.414);  // draw the iner central circle in the square
  point(xCenter, yCenter);

  strokeWeight(1);
  line(xCenter - scale / 2, yCenter, xCenter + scale / 2, yCenter); // Horizontal center line
  line(xCenter, yCenter - scale/2, xCenter, yCenter + scale / 2); // Verticle center line

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

    fill(255, 100, 100);
    ellipse(x, y, 5, 5);  //  draw the 24 points 
    noFill();
    line(xCenter, yCenter, x, y);
    noFill();

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }

  // ----------------------

  // draw the guidelines for the top bottom left and right ends of the cross 

  line(outerX[2], outerY[2], outerX[3], outerY[3]); // right verticle line of cross
  line(outerX[3], outerY[3], outerX[4], outerY[4]); // right verticle line of cross

  line(outerX[5], outerY[5], outerX[6], outerY[6]); // right verticle line of cross
  line(outerX[6], outerY[6], outerX[7], outerY[7]); // right verticle line of cross

  line(outerX[8], outerY[8], outerX[9], outerY[9]);   // right verticle line of cross
  line(outerX[9], outerY[9], outerX[10], outerY[10]); // right verticle line of cross

  line(outerX[11], outerY[11], outerX[12], outerY[12]); // right verticle line of cross
  line(outerX[12], outerY[12], outerX[1], outerY[1]);   // right verticle line of cross

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
    fill(255, 100, 100);
    ellipse(x, y, 5, 5);  //  draw the 24 points 
    noFill();
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

    fill(255, 100, 100);
    noFill();

    if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
      line(xCenter, yCenter, x, y);
    }

    noFill();

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }

  // cross guidelines
  line(innerX[4], yCenter + scale /2, innerX[4], yCenter - scale /2); // right verticle line of cross
  line(innerX[8], yCenter + scale /2, innerX[8], yCenter - scale /2); // left verticle line of cross
  line(xCenter + scale /2, innerY[10], xCenter - scale /2, innerY[10]); // top horizontal line of cross
  line(xCenter + scale /2, innerY[14], xCenter - scale /2, innerY[14]); // top horizontal line of cross

  if (drawEllipses) {

    ellipse(innerX[4], innerY[2], 15, 15); // inner top right turning point of cross
    ellipse(innerX[8], innerY[2], 15, 15); // inner top left turning poinnt of cross
    ellipse(innerX[4], innerY[14], 15, 15); // inner bottom right turning point of cross
    ellipse(innerX[8], innerY[14], 15, 15); // inner bottom left turning poinnt of cross


    // Cross outer horizontal turning points
    ellipse(outerX[5] - scale * 0.0392, innerY[10], 15, 15); // top outer left turning poinnt of cross
    ellipse(outerX[5] - scale * 0.0392, innerY[14], 15, 15); // bottom outer left turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[10], 15, 15); // top outer right turning poinnt of cross
    ellipse(outerX[1] + scale * 0.0392, innerY[14], 15, 15); // bottom outer right turning poinnt of cross

    // turning point for cross
    ellipse(xCenter - scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top left 
    ellipse(xCenter - scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom left 

    ellipse(xCenter + scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top right 
    ellipse(xCenter + scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom right
  }


}//  end void guides //////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////


void simpleGuides() {  
  //  rect(xCenter, yCenter, scale, scale);  // draw the boundray square 

  strokeWeight(1);
  line(xCenter - scale, yCenter, xCenter + scale, yCenter); // Horizontal center line
  line(xCenter, yCenter - scale, xCenter, yCenter + scale ); // Verticle center line

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

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
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

    if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
      line(xCenter, yCenter, x, y);
    }

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }

  // cross guidelines
  line(innerX[4], yCenter + scale, innerX[4], yCenter - scale); // right verticle line of cross
  line(innerX[8], yCenter + scale, innerX[8], yCenter - scale); // left verticle line of cross
  line(xCenter + scale, innerY[10], xCenter - scale, innerY[10]); // top horizontal line of cross
  line(xCenter + scale, innerY[14], xCenter - scale, innerY[14]); // top horizontal line of cross
}
