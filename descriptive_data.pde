class Description{

    private int[] results;
    private String[] names;

    public Description(){

    }

    DataResult read_data(int seed){  //read json although this is not necessary in future
 
        JSONObject json = loadJSONObject("data/globalFeature.json");
        float[][] max_size;
        float[][] points; 
        int num_color; 

        if (json == null) {
            println("JSON Object could not be parsed");
            return new DataResult(new int[] {0}, new String[] {"a"});
        }

        JSONObject densityOfHatch = json.getJSONObject("densityOfHatch");
        JSONArray bottomRight = densityOfHatch.getJSONArray("bottomRight");
        JSONArray topLeft = densityOfHatch.getJSONArray("topLeft");
        JSONArray centerOfMass = densityOfHatch.getJSONArray("centerOfMass");
        JSONArray positionOfPoints = json.getJSONArray("positionOfPoints");
                
        num_color = json.getInt("numberOfColor");
        //println("num of color :" + num_color); 
        
        max_size = new float[][] {
                {bottomRight.getFloat(0), bottomRight.getFloat(1)},
                {topLeft.getFloat(0), topLeft.getFloat(1)},
                {centerOfMass.getFloat(0), centerOfMass.getFloat(1)}
        };
        // println("max_size");    
        // print_array(max_size);
                
        points = new float[positionOfPoints.size()][2];
        
        for (int i = 0; i < positionOfPoints.size(); i++) {
            JSONArray point = positionOfPoints.getJSONArray(i);
            points[i][0] = point.getFloat(0);
            points[i][1] = point.getFloat(1);
        //println("points"); 
        //print_array(points);
        }
         

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


        return new DataResult(result, names);
        
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


    DataResult read_global_feature(int seed, GlobalFeature currentGlobalFeature) {  
 
        float[][] max_size;
        float[][] points; 
        int num_color; 

        HatchDensity densityOfHatch = currentGlobalFeature.getDensityOfHatch();
        float[] bottomRight = densityOfHatch.getBottomRight();
        float[] topLeft = densityOfHatch.getTopLeft();
        float[] centerOfMass = densityOfHatch.getCenterOfMass();
        float[][] positionOfPoints = this.convertTo2DArray(currentGlobalFeature.getPositionOfPoints());

        // JSONObject densityOfHatch = json.getJSONObject("densityOfHatch");
        // JSONArray bottomRight = densityOfHatch.getJSONArray("bottomRight");
        // JSONArray topLeft = densityOfHatch.getJSONArray("topLeft");
        // JSONArray centerOfMass = densityOfHatch.getJSONArray("centerOfMass");
        // JSONArray positionOfPoints = json.getJSONArray("positionOfPoints");
                
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
