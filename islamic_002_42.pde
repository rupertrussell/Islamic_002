// By Rupert Russell
// 30 May 2018
// https://github.com/rupertrussell/Islamic_002
// MIT licence
// Not ellegant
// Not optimised but it does the job
// webpage with details of my progress at: http://www.rupert.id.au/processing/examples/projection/index.html

// I am wanting to reproduce this design
// https://www.theguardian.com/science/alexs-adventures-in-numberland/2015/feb/10/muslim-rule-and-compass-the-magic-of-islamic-geometric-design

boolean drawCross = true;

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
float scale = 550 ; // scale of bounding square
float xCenter = 600/2;
float yCenter = 600/2;
float start = radians(0);
float stop = radians(0);
int outerWeight = 15; // Thickness of outer stroke
int innerWeight = 3; // thicknes of inner stroke

void setup() {
  size(600, 600); // width x height
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
}

void draw() {
  background(115, 185, 214);
  noLoop();

  guides();

  stroke(255);
  drawTheCross(outerWeight); // Outer white lines

  stroke(255);
  drawCornerAngles(outerWeight);
  stroke(255);

  star2Points(); // draw the ends of the stat
  starPoints();  // set the values for the star turning points

  drawStarLines(outerWeight); 
  stroke(0, 0, 0);  
  drawStarLines(innerWeight);

  stroke(0, 0, 0);
  drawCornerAngles(innerWeight);
  stroke(255);

  stroke(0, 0, 0);
  drawTheCross(innerWeight); // inner black lines
}  // end Draw()

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("Islamic_002_42.png");
    exit();
  }
}
void guides() {  

  // calculate 12 points around the outer circle
  counter = 0;
  double step = radians(360/12); 
  float h = xCenter; 
  float k = yCenter;
  float r =  scale /2;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
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

  // outer circle used to determine points on boundary square
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
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }
  // ----------------------

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
    counter ++;
    if (counter ==13) {
      counter = 0;
    }
  }
}//  end void guides //

void drawTheCross(int weight) {
  if (drawCross) {
    // draw cross
    strokeWeight(weight);
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

void starPoints() {

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
}


void drawCornerAngles(int weight) {
  // draw corner angles
  strokeWeight(weight);
  // top left corner
  line(xCenter - scale * 0.1691, yCenter - scale * 0.5, xCenter - scale * 0.22435, yCenter - scale * testY); // start point top left boundary square
  line(xCenter - scale * 0.22435, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * testY); // working downwards and leftwards
  line(xCenter - scale * testY, yCenter - scale * testY, xCenter - scale * testY, yCenter - scale * 0.22435);
  line(xCenter - scale * testY, yCenter - scale * 0.22435, xCenter - scale * 0.5, yCenter - scale * 0.1691);

  // bottom left corner
  line(xCenter - scale * 0.5, yCenter + scale * 0.1691, xCenter - scale * testY, yCenter + scale * 0.22435); // start point bottom left boundary square
  line(xCenter - scale * testY, yCenter + scale * 0.22435, xCenter - scale * testY, yCenter + scale * testY); // working downwards and rightwards
  line(xCenter - scale * testY, yCenter + scale * testY, xCenter - scale * 0.22435, yCenter + scale * testY);
  line(xCenter - scale * 0.22435, yCenter + scale * testY, xCenter - scale * 0.1691, yCenter + scale * 0.5);

  // bottom right corner
  line(xCenter + scale * 0.1691, yCenter + scale * 0.5, xCenter + scale * 0.22435, yCenter + scale * testY);
  line(xCenter + scale * 0.22435, yCenter + scale * testY, xCenter + scale * testY, yCenter + scale * testY);
  line(xCenter + scale * testY, yCenter + scale * testY, xCenter + scale * testY, yCenter + scale * 0.22435);
  line(xCenter + scale * testY, yCenter + scale * 0.22435, xCenter + scale * 0.5, yCenter + scale * 0.1691);
  // top right corner

  line(xCenter + scale * 0.5, yCenter - scale * 0.1691, xCenter + scale * testY, yCenter - scale * 0.22435);
  line(xCenter + scale * testY, yCenter - scale * 0.22435, xCenter + scale * testY, yCenter - scale * testY);
  line(xCenter + scale * testY, yCenter - scale * testY, xCenter + scale * 0.22435, yCenter - scale * testY);
  line(xCenter + scale * 0.22435, yCenter - scale * testY, xCenter + scale * 0.1691, yCenter - scale * 0.5);
}

void drawStarLines(int weight) {
  strokeWeight(weight);
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

void star2Points() {

  // Star Two Guidelines **
  // calculate 24 points around the starTwo circle
  println("inside * starTwo");
  counter = 0;
  double step = radians(360/24);
  float h = xCenter; 
  float k = yCenter;
  float r = scale * 0.293 / 2; 
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta);
    starTwoX[counter] = x;  // Save the calculated values
    starTwoY[counter] = y;  // Save the calculated values
    counter ++;
    if (counter ==25) {
      counter = 0;
    }
  } // end Star Two Guidelines **
}
