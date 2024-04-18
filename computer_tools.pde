
int seed;     

void computer_draw(GlobalFeature currentGlobalFeature) {
    strokeWeight(2);
    /**data will be realocated. This is pretransformed. **/
    Description descriptive = new Description(); 
    // DataResult dataResult = descriptive.read_data(seed); 
    DataResult dataResult = descriptive.read_global_feature(seed, currentGlobalFeature);
    
    int[] styles = dataResult.intResult;
    String[] names = dataResult.stringResult;
    int[] shuffledIndices = shuffleArray(styles.length);
    
    
    /**allocation**/
    int numPoints = styles[shuffledIndices[0]];
    String pointNames = names[shuffledIndices[0]];
    println("numPoints  :" + pointNames + ", " + numPoints); 
    int factor = styles[shuffledIndices[1]];
    String factorNames = names[shuffledIndices[1]];
    println("factor  :" + factorNames + ", " + factor); 
    int numColor = styles[shuffledIndices[2]];
    String colorNames = names[shuffledIndices[2]];
    println("numColor  :" + colorNames + ", " + numColor); 
    
    /**style allocation is required. Should be predesignated by conditions**/
    Boundary boundary = new Torso2(); 
    Pattern pattern1 = new Pattern(numPoints, factor, numColor, boundary, true);
    pattern1.ellipse_generator(); 
    Pattern pattern2 = new Pattern(numPoints, factor, numColor, boundary, false);
    pattern2.diagonal_generator(); 
    
    
    Line lineType = new Line(boundary, numPoints, factor, numColor);
    //lineType.chain_generator();
    lineType.coil_generator();
    
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
    