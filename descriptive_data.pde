class Description{

    private int[] results;
    private String[] names;
    private float[][] testCase;

    public Description(){

    }

    DataResult read_data(int seed){  //read json although this is not necessary in future
 
        JSONObject json = loadJSONObject("data/globalFeature.json");
        float[][] max_size;
        float[][] points; 
        int num_color; 

        if (json == null) {
            println("JSON Object could not be parsed");
            return new DataResult(new int[] {0}, new String[] {"a"}, new float[1][1]);
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
         

        int maxLength = (int)dist(max_size[0][0], max_size[0][1], max_size[1][0], max_size[1][1]);
        int num_points = points.length/10;
        randomSeed(seed);
        float random_posX = points[(int)random(1, points.length)][0];
        float random_posY = points[(int)random(1, points.length)][1];
        //println("X, Y" +random_posX +"," +random_posY); 

        int[] result = {num_color, maxLength, num_points, 
                        (int)random_posX, (int)random_posY};

        String[] names = {"num_color", "maxLength", "num_points", 
                                "random_posX", "random_posY"};

        float[][] tests = points;

        return new DataResult(result, names, tests);
        
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
    float[][] testPointArray;
    
    DataResult(int[] intResult, String[] stringResult, float[][] testPointArray){
        this.intResult = intResult;
        this.stringResult = stringResult;
        this.testPointArray = testPointArray;
    }
}