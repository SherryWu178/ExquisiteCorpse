import java.util.HashMap;

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
   
        this.numColor = styles[shuffledIndices[2]];
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

        if (pretransformParameters.getNumberOfPoints() > 3) { // Corrected method call
            boundary = new Torso2();
        } else {
            boundary = new Torso1();
        }
        
        if (pretransformParameters.getNumberOfColor() > 1) { // Corrected method call
            lineTool = new CoilLineTool(this.numPoints, this.factor, this.numColor, boundary);
        } else {
            lineTool = new ChainLineTool(this.numPoints, this.factor, this.numColor, boundary);
        }

        if (pretransformParameters.getNumberOfColor() > 3) { // Corrected method call
            outsidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        } else {
            outsidePatternTool = new EllipsePatternTool(this.numPoints, this.factor, this.numColor, boundary, false);
        }

        if (pretransformParameters.getNumberOfPoints() > 10) { // Corrected method call
            insidePatternTool = new EllipsePatternTool(this.numPoints, this.factor, this.numColor, boundary, true);
        } else {
            insidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor, this.numColor, boundary, true);
        }

        Style style = new Style(boundary, insidePatternTool, outsidePatternTool, lineTool);
        
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
