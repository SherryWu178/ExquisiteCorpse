class Description{

    private int[] results;
    private String[] names;

    public Description() {
    }

    public float[][] convertTo2DArray(List<float[]> listOfArrays) {
        int numRows = listOfArrays.size();
        int numCols = listOfArrays.get(0).length;

        // Initialize the 2D array
        float[][] twoDArray = new float[numRows][numCols];

        // Copy elements from the list to the 2D array
        for (int i = 0; i < numRows; i++) {
            twoDArray[i] = listOfArrays.get(i);
        }

        return twoDArray;
    }


    DataResult read_global_feature(int seed, PretransformParameters currentGlobalFeature) {  
 
        float[][] max_size;
        float[][] points; 
        int num_color; 

        HatchDensity densityOfHatch = currentGlobalFeature.getDensityOfHatch();
        float[] bottomRight = densityOfHatch.getBottomRight();
        float[] topLeft = densityOfHatch.getTopLeft();
        float[] centerOfMass = densityOfHatch.getCenterOfMass();
        float[] stdDev = densityOfHatch.getStdDev();

        float[][] positionOfPoints = this.convertTo2DArray(currentGlobalFeature.getPositionOfPoints());
                
        num_color = currentGlobalFeature.getNumberOfColor();
        float[] curvatures = currentGlobalFeature.getCurvatures();
        float[] shapeLengths = currentGlobalFeature.getShapeLengths();

        max_size = new float[][] {
                {bottomRight[0], bottomRight[1]},
                {topLeft[0], topLeft[1]},
                {centerOfMass[0], centerOfMass[1]}
        };

        points = positionOfPoints;

        // no random 
        int minX = (int)bottomRight[0] + 1;
        int minY = (int)bottomRight[1] + 1;
        int maxX = (int)topLeft[0];
        int maxY = (int)topLeft[1];
        int meanX = (int)centerOfMass[0] + 1;
        int meanY = (int)centerOfMass[1];
        int stdX = (int)stdDev[0];
        int stdY = (int)stdDev[1];
        int minLength = (int)shapeLengths[0] + 1;
        int maxLength = (int)shapeLengths[1] + 1;
        int minCurvature = (int)curvatures[0] + 2;
        int maxCurvature = (int)curvatures[1] + 2;
        num_color += 12; //insurance
        int coverage = (int)dist(max_size[0][0], max_size[0][1], max_size[1][0], max_size[1][1]) + 1;//insurance
        int num_points = points.length + 1; //insurance

        int[] result = {minX, minY, maxX, maxY, meanX, meanY, 
                        stdX, stdY, minLength, maxLength, minCurvature, 
                        maxCurvature, num_color, coverage, num_points};

        String[] names = {"minX", "minY", "maxX", "maxY", "meanX", "meanY", 
                        "stdX", "stdY", "minLength", "maxLength", "minCurvature", 
                        "maxCurvature", "num_color", "coverage", "num_points"};
                                
        for (int i = 0; i < result.length; i++) {
            println(names[i] + " : " + result[i]);
        }
        
        return new DataResult(result, names);
        
    }  

    void print_array(float[][] s) //print array
    {
        println(":");
        for (int i = 0; i < s.length; i++) {
            print("[");
            for (int j = 0; j < s[i].length; j++) {
                print(s[i][j]);
                if (j < s[i].length - 1) {
                    print(", ");
                }
            }
            println("]");
        } 
    }
}

class DataResult {
    int[] intResult;
    String[] stringResult;
    
    DataResult(int[] intResult, String[] stringResult){
        this.intResult = intResult;
        this.stringResult = stringResult;
    }
}
