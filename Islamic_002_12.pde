// I am wanting to reproduce this design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design#img-8
// http://wiki.roblox.com/index.php?title=Dot_product

//https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
// https://martin-thoma.com/how-to-check-if-two-line-segments-intersect/

// http://www.sunshine2k.de/coding/java/PointOnLine/PointOnLine.html#step5
// https://en.wikibooks.org/wiki/Linear_Algebra/Orthogonal_Projection_Onto_a_Line
// Cite this chapter as: Bonner J. (2017) 3 Polygonal Design Methodology. In: Islamic Geometric Patterns. Springer, New York, NY
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=61ACU_ALMA51128361450002352&context=L&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US
// https://acu-edu-primo.hosted.exlibrisgroup.com/primo-explore/fulldisplay?docid=TN_proquest1688306298&context=PC&vid=61ACU&search_scope=61ACU_All&tab=61acu_all&lang=en_US
boolean test = false;

float[] innerX; // store xPoints for the 24 points on the inner circle
float[] innerY; // store yPoints for the 24 points on the inner circle

float[] outerX; // store xPoints for the 12 points on the outer circle
float[] outerY; // store yPoints for the 12 points on the outer circle

float[] outerMostX; // store xPoints for the 12 points on the outer circle
float[] outerMostY; // store yPoints for the 12 points on the outer circle


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
  // size(6000, 6000); // width x height test case

  noFill();
  // noLoop();

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
    stroke(255, 0, 0);
    strokeWeight(5);
    line(400, 400, 6000 - 400, 400); 
    stroke(0);
    strokeWeight(1);

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
      
      if(counter == 20){
      stroke(255,0,255);
      //  line(2482, 0, 2482, 6000); // was 2479
        line(scale * 0.4964, 0, scale * 0.4964, 6000); // was 2479
        
        //ellipse(scale * 0.4964, scale * 0.1276, 8, 8); 
        //  println("scale / 2482 = "+ 2482 / scale);
        //  println("test = " + 2482 / scale);
          
        stroke(0);
      
        
      }

        counter ++;
    }
    strokeWeight(1);
  } else {
    //scale = 500 ; // scale of bounding square
    //xCenter = 600/2;
    //yCenter = 600/2;
  }


  stroke(0);
  strokeWeight(2);

  rectMode(CENTER);

  rect(xCenter, yCenter, scale, scale);  // draw the boundray square 

  stroke(255, 0, 0);
  strokeWeight(2);

  // outer circle used to determine points on boundary square
  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  // ellipse(xCenter, yCenter, scale * 1.154, scale * 1.154);  // draw the central circle in the square


  stroke(0);
  strokeWeight(1);

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

    fill(255, 0, 0);
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

  line(outerX[8], outerY[8], outerX[9], outerY[9]); // right verticle line of cross
  line(outerX[9], outerY[9], outerX[10], outerY[10]); // right verticle line of cross

  line(outerX[11], outerY[11], outerX[12], outerY[12]); // right verticle line of cross
  line(outerX[12], outerY[12], outerX[1], outerY[1]); // right verticle line of cross



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
    fill(255, 0, 0);
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
  //stroke(255, 0, 0);
  //strokeWeight(2);
  //ellipse(xCenter, yCenter, r * 2, r * 2);  // draw the outermost  circle

  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);

    // println("counter = " + counter);
    outerMostX[counter] = x;
    outerMostY[counter] = y;

    fill(255, 0, 0);

    noFill();


    if ((counter == 1) ||  (counter == 2) || (counter == 4) || (counter == 5) || (counter == 7) || (counter == 8) || (counter == 10) || (counter == 11)) {
      line(xCenter, yCenter, x, y);
      //ellipse(x, y, 10, 10);  //  draw the 12 points
    }

    stroke(0);
    strokeWeight(1);
    noFill();

    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }


  line(innerX[4], yCenter + scale /2, innerX[4], yCenter - scale /2); // right verticle line of cross
  line(innerX[8], yCenter + scale /2, innerX[8], yCenter - scale /2); // left verticle line of cross

  line(xCenter + scale /2, innerY[10], xCenter - scale /2, innerY[10]); // top horizontal line of cross
  line(xCenter + scale /2, innerY[14], xCenter - scale /2, innerY[14]); // top horizontal line of cross


  noFill();
  ellipse(innerX[4], innerY[2], 15, 15); // inner top right turning point of cross
  ellipse(innerX[8], innerY[2], 15, 15); // inner top left turning poinnt of cross

  ellipse(innerX[4], innerY[14], 15, 15); // inner bottom right turning point of cross
  ellipse(innerX[8], innerY[14], 15, 15); // inner bottom left turning poinnt of cross

 // turning point for cross
 strokeWeight(1);
 stroke(255,0,0);
 ellipse(xCenter - scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top left 
 ellipse(xCenter - scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom left 

 ellipse(xCenter + scale * 0.1036, yCenter - scale * 0.4723, 15, 15);  // top right 
 ellipse(xCenter + scale * 0.1036, yCenter + scale * 0.4723, 15, 15);  // bottom right 


// draw cross
strokeWeight(4);


line(xCenter - scale * 0.1036, yCenter - scale * 0.4723, outerX[3], outerY[3]); // top left to center line
line(outerX[3], outerY[3], xCenter + scale * 0.1036, yCenter - scale * 0.4723); // center line to top right
line(xCenter + scale * 0.1036, yCenter - scale * 0.4723, innerX[4], innerY[2]); // top right verticle line



println("innerX[4] = " + innerX[4]);
float temp = xCenter + scale * 0.1036;
println("xCenter + scale * 0.1036" + temp);


  if (test == true) {
    save("Islamic_002_13.png");
    exit();
  }
}


void mousePressed() {

  scale = 200; // scale of bounding square
  xCenter = 150;
  yCenter = 150;
  println("Mouse Pressed");
}

void mouseReleased() {

  scale = 500; // scale of bounding square
  xCenter = 300;
  yCenter = 300;
    println("Mouse Released");
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("Islamic_002_12.png");
    exit();
  }
}
