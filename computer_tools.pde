
int seed;       /**********************************/

// void setup() {  //computer doesn't need draw()
//   /**Set the size of the sketch**/
//   size(700, 650);
//   background(255);
//   smooth();
//   seed = (int)random(100);
  
// } 

void computer_draw() {

  /**data will be realocated. This is pretransformed. **/
  Description descriptive = new Description(); 
  DataResult dataResult = descriptive.read_data(seed); /**********************************/
  int[] styles = dataResult.intResult;
  String[] names = dataResult.stringResult;
  int[] shuffledIndices = shuffleArray(styles.length);
  
  
  /**allocation**/
  int numPoints = styles[shuffledIndices[0]];
  String pointNames = names[shuffledIndices[0]];
  println("numPoints  :" + pointNames + ", " +numPoints); 
  int factor = styles[shuffledIndices[1]];
  String factorNames = names[shuffledIndices[1]];
  println("factor  :" + factorNames + ", " + factor); 
  int numColor = styles[shuffledIndices[2]];
  String colorNames = names[shuffledIndices[2]];
  println("numColor  :" + colorNames + ", " + numColor); 

  /**style allocation is required. Should be predesignated by conditions**/
  Boundary boundary = new Torso2(); 
  Pattern pattern1 = new Pattern(numPoints, factor, numColor, boundary, true);
  pattern1.ellipse_generator(); /**********************************/
  Pattern pattern2 = new Pattern(numPoints, factor, numColor, boundary, false);
  pattern2.diagonal_generator(); /**********************************/


  /**test line Array for tracing. this will be included in class.**/
  /**two pairs**/
  float[][] testPoints = dataResult.testPointArray;
  float[] p1;
  float[] p2;
  float[][] pairs = new float[testPoints.length][4];
  float[] lengths = new float[testPoints.length];
  PVector[] vec = new PVector[testPoints.length];
  float min = width; 
  float max = 0;

  for (int i = 0; i < testPoints.length; i++){
    p1 = testPoints[i];
    if (i + 1 == testPoints.length) {
      p2 = testPoints[0];
    } else {
      p2 = testPoints[i + 1];
    } 
    PVector point1 = new PVector(p1[0], p1[1]);
    PVector point2 = new PVector(p2[0], p2[1]);
    vec[i] = PVector.sub(point2, point1).normalize();
    lengths[i] = dist(p1[0], p1[1], p2[0], p2[1]);
    if (min < lengths[i])  min = lengths[i]; 
    if (max > lengths[i])  max = lengths[i]; 
  }

  Line lineType = new Line(boundary, testPoints, lengths, vec, min, max,
                          numPoints, factor, numColor);
  // lineType.chain_generator(testPoints, lengths, vec, min, max,
  //                     numPoints, factor, numColor);
  lineType.coil_generator();

  /*********Original line by Sherry. This lines are going to be a torso**********/
  for (int i = 0; i < testPoints.length - 1; i++) {
    strokeWeight(1);
    stroke(0);
    line(testPoints[i][0], testPoints[i][1], testPoints[i+1][0], testPoints[i+1][1]);
  } //what did you draw..
}



// Method to shuffle array indices
int[] shuffleArray(int size) {
  int[] indices = new int[size];
  for (int i = 0; i < size; i++) {
    indices[i] = i;
  }
  
  for (int i = size - 1; i > 0; i--) {
    //randomSeed(bud + i);
    int j = (int)random(i + 1);

    int temp = indices[i];
    indices[i] = indices[j];
    indices[j] = temp;
  }
  return indices;
}







