import java.util.HashMap;

4 pattern toll
(number_c + number_P + number ) mod (4)


class StyleMappingTable {
    int numPoints;
    int factor;
    int numColor;

    StyleMappingTable(DataResult dataResult) {
        this.shuffle(dataResult);
    }

    // Method to shuffle the data, used in constructor
    public void shuffle(DataResult dataResult) {
        int[] styles = dataResult.intResult;
        String[] names = dataResult.stringResult;
        int[] shuffledIndices = shuffleArray(styles.length);
        
        /**allocation**/
        this.numPoints = styles[shuffledIndices[0]];
        String pointNames = names[shuffledIndices[0]];
        
        this.factor = styles[shuffledIndices[1]];
        String factorNames = names[shuffledIndices[1]];
        
        if (this.numColor == 0) {
            this.numColor = styles[shuffledIndices[2]] + 1;
        }
        String colorNames = names[shuffledIndices[2]];

        println("numPoints  :" + pointNames + ", " + numPoints); 
        println("factor  :" + factorNames + ", " + factor); 
        println("numColor  :" + colorNames + ", " + numColor); 
    }

    public Style generateStyle(PretransformParameters pretransformParameters) {
        Boundary boundary;
        PatternTool insidePatternTool;
        PatternTool outsidePatternTool;
        LineTool lineTool;
        FunTool funTool;

        if (pretransformParameters.getNumberOfPoints() > 3) { // Corrected method call
            boundary = new Torso2();
        } else {
            boundary = new Torso1();
        }
        
        if (pretransformParameters.getNumberOfColor() > 4) { // Corrected method call
            lineTool = new CoilLineTool(this.numPoints, this.factor, this.numColor, boundary);
        } else if (pretransformParameters.getNumberOfPoints() > 2){
            lineTool = new ChainLineTool(this.numPoints, this.factor, this.numColor, boundary);
        } else if (pretransformParameters.getNumberOfPoints() > 1){
            lineTool = new HornLineTool(this.numPoints, this.factor, this.numColor, boundary);
        } else {
            lineTool = new SpringLineTool(this.numPoints, this.factor, this.numColor, boundary);
        }


        if (pretransformParameters.getNumberOfColor() > 5) { // Corrected method call
            outsidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        } else if((pretransformParameters.getNumberOfColor() > 3) ) {
            outsidePatternTool = new EllipsePatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        } else {
           outsidePatternTool = new DotsPatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        }

        if (pretransformParameters.getNumberOfPoints() > 30) { // Corrected method call
            insidePatternTool = new EllipsePatternTool(this.numPoints, this.factor, this.numColor, boundary, true);
        } else if (pretransformParameters.getNumberOfPoints() > 15) {
            insidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor, this.numColor, boundary, true);
        } else {
           insidePatternTool = new DotsPatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        }
 
        if (pretransformParameters.getNumberOfColor() > 5) { // Corrected method call
            funTool = new Noise1FunTool(this.numPoints, this.numColor, boundary, true);
        } else if (pretransformParameters.getNumberOfPoints() > 3) {
            funTool = new Noise2FunTool(this.numPoints, this.numColor, boundary, true);
        } else {
            funTool = new DefaultFunTool(this.numPoints, this.numColor, boundary, true);
        }

        Style style = new Style(boundary, insidePatternTool, outsidePatternTool, lineTool, funTool);
        
        return style;
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
}
