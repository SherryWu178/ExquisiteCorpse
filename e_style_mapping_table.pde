import java.util.HashMap;

class StyleMappingTable {
    int numPoints;
    int factor1;
    int factor2;
    int numColor;
    int transp;
    int radius;
    int angle;
    int stroke;

    StyleMappingTable(DataResult dataResult) {
        this.shuffle(dataResult);
    }

    // Method to shuffle the data, used in constructor
    public void shuffle(DataResult dataResult) {
        int[] styles = dataResult.intResult;
        String[] names = dataResult.stringResult;
        int[] shuffledIndices = shuffleArray(styles.length);
        
        /**allocation**/
        this.numPoints = styles[shuffledIndices[0]] + styles[shuffledIndices[8]];
        String pointNames = names[shuffledIndices[0]];
        
        this.factor1 = styles[shuffledIndices[1]] + styles[shuffledIndices[9]];
        String factor1Names = names[shuffledIndices[1]];
   
        this.numColor = styles[shuffledIndices[2]] + styles[shuffledIndices[10]];
        String colorNames = names[shuffledIndices[2]];

        this.transp= styles[shuffledIndices[3]] + styles[shuffledIndices[11]];
        String transpNames = names[shuffledIndices[3]];

        this.radius = styles[shuffledIndices[4]] + styles[shuffledIndices[12]];
        String radiusNames = names[shuffledIndices[4]];

        this.angle = styles[shuffledIndices[5]] + styles[shuffledIndices[13]];
        String angleNames = names[shuffledIndices[5]];

        this.stroke = styles[shuffledIndices[6]] + styles[shuffledIndices[14]];
        String strokeNames = names[shuffledIndices[6]];

        this.factor2 = styles[shuffledIndices[7]];
        String factor2Names = names[shuffledIndices[7]];

        // println("numPoints  :" + pointNames + ", " + numPoints); 
        // println("factor1  :" + factor1Names + ", " + factor1); 
        // println("factor2  :" + factor2Names + ", " + factor2); 
        // println("numColor  :" + colorNames + ", " + numColor); 
        // println("stroke  :" + strokeNames + ", " + stroke); 
        // println("transp  :" + transpNames + ", " + transp); 
        // println("radius  :" + radiusNames + ", " + radius); 
        // println("angle  :" + angleNames + ", " + angle); 
    }

    public Style generateStyle(PretransformParameters pretransformParameters) {
        HatchDensity densityOfHatch = pretransformParameters.getDensityOfHatch();
        Boundary boundary;
        PatternTool insidePatternTool;
        PatternTool outsidePatternTool;
        LineTool lineTool;
        FunTool funTool;

        int cal1 = (int)pretransformParameters.getCurvatures()[0] 
                    + (int)densityOfHatch.getCenterOfMass()[1]
                    + (int)pretransformParameters.getShapeLengths()[1] + (int)random(1, 10);
        int cal2 = (int)pretransformParameters.getCurvatures()[1]
                    + (int)densityOfHatch.getCenterOfMass()[0]
                    + (int)pretransformParameters.getShapeLengths()[0] + (int)random(1, 10);
        int cal3 = (int)pretransformParameters.getPositionOfPoints().get(0)[0]
                    + (int)densityOfHatch.getBottomRight()[1]
                    + (int)pretransformParameters.getPositionOfPoints().get(0)[1] + (int)random(1, 10);
        int cal4 = cal1 + cal2 + (int)random(1, 10);
        int cal5 = cal3 + cal4 + (int)random(1, 10);
        println("cal1, boundary type  :" + cal1);
        println("outside  :" + cal2);
        println("funtool  :" + cal3);
        println("inside  :" + cal4);
        println("line  :" + cal5);

        if (cal1 % 2 == 0) { // Corrected method call
            boundary = new Torso2();
        } else {
            boundary = new Torso1();
        }
        
        //01. outside
        if (cal2 % 3 == 0) { // Corrected method call
            outsidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor1, this.factor2, this.numColor, boundary, false);
            println("outside  :   DiagonalPatternTool");
        } else if(cal2 % 3 == 1) {
            outsidePatternTool = new EllipsePatternTool(this.numPoints, this.factor1, 
                                                        this.factor2, this.numColor, 
                                                        boundary, true, this.angle, 
                                                        this.stroke, this.transp);
            println("outside  :   EllipsePatternTool");
        } else {
           outsidePatternTool = new DotsPatternTool(this.numPoints, this.factor1, this.factor2, this.numColor, boundary, false);
            println("outside  :   DotsPatternTool");
        }

        //02. effect
        if (cal3 % 5 == 1) { // Corrected method call
            funTool = new Noise1FunTool(this.numPoints, this.numColor, boundary, true);
            println("Noise1, white");
        } else if (cal3 % 5 == 2) {
            funTool = new Noise2FunTool(this.numPoints, this.numColor, boundary, true);
            println("Noise2, dark");
        } else {
            funTool = new DefaultFunTool(this.numPoints, this.numColor, boundary, true);
            println("no Noise");   
        }


        //03. inside
        if (cal4 % 3 == 0) { // Corrected method call
            insidePatternTool = new EllipsePatternTool(this.numPoints, this.factor1, 
                                                        this.factor2, this.numColor, 
                                                        boundary, true, this.angle, 
                                                        this.stroke, this.transp);
            println("inside  :   EllipsePatternTool");
        } else if (cal4 % 3 == 1) {
            insidePatternTool = new DiagonalPatternTool(this.numPoints, this.factor1, this.factor2, this.numColor, boundary, true);
            println("inside  :   DiagonalPatternTool");
        } else {
            insidePatternTool = new DotsPatternTool(this.numPoints, this.factor1, this.factor2, this.numColor, boundary, false);
            println("inside  :   DotsPatternTool");
        }
 
        //04. line
        if (cal5 % 4 == 0) { // Corrected method call
            lineTool = new CoilLineTool(this.numPoints, this.factor1, this.factor2, 
                                        this.numColor, boundary);
            println("line  :   CoilLineTool");
        } else if (cal5 % 4 == 1){
            lineTool = new ChainLineTool(this.numPoints, this.factor1, this.factor2, 
                                        this.numColor, boundary, 
                                        this.stroke, this.transp, this.radius);
            println("line  :   ChainLineTool");
        } else if (cal5 % 4 == 2){
            lineTool = new HornLineTool(this.numPoints, this.factor1, this.factor2, 
                                        this.numColor, boundary,
                                        this.stroke, this.angle);
            println("line  :   HornLineTool");
        } else {
            lineTool = new SpringLineTool(this.numPoints, this.factor1, this.factor2, 
                                        this.numColor, boundary);
            println("line  :   SpringLineTool");       
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
