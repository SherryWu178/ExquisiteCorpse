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
        float[][] positionOfPoints = this.convertTo2DArray(currentGlobalFeature.getPositionOfPoints());
                
        num_color = currentGlobalFeature.getNumberOfColor();
        //println("num of color :" + num_color); 
        
        max_size = new float[][] {
                {bottomRight[0], bottomRight[1]},
                {topLeft[0], topLeft[1]},
                {centerOfMass[0], centerOfMass[1]}
        };
        // println("max_size");    
        // print_array(max_size);
                
        points = positionOfPoints;
         

        int maxLength = (int)dist(max_size[0][0], max_size[0][1], max_size[1][0], max_size[1][1]) + 1;//insurance
        int num_points = points.length/10 + 1;//insurance
        randomSeed(seed);
        float random_posX = points[(int)random(points.length)][0]; //insurance
        float random_posY = points[(int)random(points.length)][1]; //insurance
        num_color += 12; //insurance
        //println("X, Y" +random_posX +"," +random_posY); 

        int[] result = {num_color, maxLength, num_points, 
                        (int)random_posX, (int)random_posY};

        String[] names = {"num_color", "maxLength", "num_points", 
                                "random_posX", "random_posY"};
                                
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
