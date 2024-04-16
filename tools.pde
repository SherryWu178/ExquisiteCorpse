class Line{
    private Boundary boundary;
    private float[][] pos;
    private float[] lengths;
    private PVector[] vec;
    private float min;
    private float max;
    private int numPoints;
    private int factor;
    private int numColor;

    // kindly change to pls List<float[]> coordinatesList = new ArrayList<>();

    public Line(Boundary boundary, float[][] pos, float[] lengths, PVector[] vec,
                float min, float max, 
                int numPoints, int factor, int numColor)
    {   
        this.boundary = boundary;
        this.pos = pos;
        this.lengths = lengths;
        this.vec = vec;
        this.min = min;
        this.max = max;   
        this.numPoints = numPoints;
        this.factor = factor;
        this.numColor = numColor;
    }

    
    private void coil_generator()
    {
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //r size 
        if (numPoints > 50) numPoints %= 50;

        List<float[]> coordinatesList = boundary.getCoordinatesList();

        for (int i = 0; i < coordinatesList.size() -1; i++){   
            stroke(colors[i % numColor]);
            strokeWeight(factor * i % 5);

            float r = lengths[i] / numPoints;
            coil(coordinatesList.get(i)[0], coordinatesList.get(i)[1], coordinatesList.get(i + 1)[0], coordinatesList.get(i+1)[1], r/2, r);            
        }
    }

    private void chain_generator()
    {
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //unit size 
        if (numPoints > 50) numPoints %= 50;
         
        // if (min / 3 > max/numPoints || min < max/numPoints) unit = (int)min / 3;
        // unit = (int)max / numPoints; 
        
        //normalized vectors;
        List<float[]> coordinatesList = boundary.getCoordinatesList();

        for (int i = 0; i < lengths.length; i++){   
            stroke(colors[i % numColor]);
            strokeWeight(factor * i % 5);

            float unit = lengths[i] / numPoints;
            PVector position = new PVector(coordinatesList.get(i)[0], coordinatesList.get(i)[1]);
            PVector direction = vec[i];
            
            for (int j = 0; j < numPoints; j++) {
                
                PVector currentPoint = PVector.add(position, PVector.mult(direction, j * unit));
                
                ellipse(currentPoint.x, currentPoint.y, numColor * j % 50 , numColor * j % 50 );
            } 
            // PVector endPos = PVector.add(position, PVector.mult(direction, unit));
            // line(pos[i][0], pos[i][1], endPos.x, endPos.y);
        }

        // a = points[i][0] + cos(radians(ang))*50;
        // b = points[i][1] + sin(radians(ang))*50;
    }

    // private void horn_generator{
    //     //random horns
    // }

    // private void diagonal_ellipse_generator{
    //     //random horns
    // }
}

class Pattern{
    private Boundary boundary;
    private int numPoints;
    private int factor;
    private int numColor;
    private boolean isInside;

    public Pattern(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside)
    {   
        this.boundary = boundary;
        this.numPoints = numPoints;
        this.factor = factor;
        this.numColor = numColor;
        this.isInside = isInside;
    }

    private void ellipse_generator()
    {
        if (numPoints < 10) numPoints *= 2;
        if (numPoints > 500) numPoints %= 300;
        int[][] points = new int[numPoints][2]; 
        
        int minX = 0; 
        int minY = 0; 

        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1);
        
        // Position the points randomly, split by Sherry
        for (int i = 0; i < numPoints; i++) {
            int x = (int)random(minX, width); 
            int y = (int)random(minY, height); 
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            fill(colors[i % numColor]);
            if (boundary.contains(points[i]) == isInside) {
                ellipse(points[i][0], points[i][1], random(0, width/5), random(0, height/5)); 
            }
            //println(numPoints);
        }
    }


    private void diagonal_generator()
    {
        if (numPoints < 10) numPoints *= 10;
        int[][] points = new int[numPoints][2]; 
        
        int minX = 0; 
        int minY = 0; 
        float a;
        float b;

        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/30 + 1);

        
        // Position the points randomly, split by Sherry
        for (int i = 0; i < numPoints; i++) {
            int x = (int)random(minX, width); 
            int y = (int)random(minY, height); 
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            if (boundary.contains(points[i]) == isInside) {
                stroke(colors[i % numColor]);
                int ang = ((int)(Math.random() * 13)) * 30;
                a = points[i][0] + cos(radians(ang))*50;
                b = points[i][1] + sin(radians(ang))*50;
                line(points[i][0], points[i][1], a, b);
            }
            
        }
    }

}

class FunEffect{

}

// will be more generators
class Color{

    private int numColor;

    public Color(int numColor)
    {
        this.numColor = numColor;
    }

    public color[] colorBySize(int numColor, int factor){
        color[] colors = new color[numColor]; 
        
        int minSize = 5/factor; 
        int maxSize = 255/factor;
        
        for (int i = 0; i < numColor; i++) {
        int r = (int)random(minSize, maxSize); 
        int g = (int)random(minSize, maxSize); 
        int b = (int)random(minSize, maxSize); 
        colors[i] = color(r, g, b);
        }
        return colors;
    }
}
