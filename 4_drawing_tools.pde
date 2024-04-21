interface Tool {
}

class LineTool implements Tool {
    // Fields declaration
    public Boundary boundary;
    public int numPoints;
    public int factor;
    public int numColor;

    // Constructor
    public LineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        // Assign values to fields
        this.numPoints = numPoints;
        this.factor = factor;
        this.numColor = numColor;
        this.boundary = boundary;
    }

    public void display() {
        randomSeed(seed);
        // Method implementation
    }
}

class CoilLineTool extends LineTool {
    public CoilLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    public void display(DisplayMode mode) {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //r size 
        if (numPoints > 50) numPoints %= 50;

        List<float[]> coordinatesList = boundary.getCoordinatesList();
          float[] p1;
          float[] p2;
          float[] lengths = new float[coordinatesList.size()];
          PVector[] vec = new PVector[coordinatesList.size()];
          float min = width; 
          float max = 0;
        
          for (int i = 0; i < coordinatesList.size(); i++){
            p1 = coordinatesList.get(i);
            if (i + 1 == coordinatesList.size()) {
              p2 = coordinatesList.get(0);
            } else {
              p2 = coordinatesList.get(i+1);
            } 
            lengths[i] = dist(p1[0], p1[1], p2[0], p2[1]);
          }

        for (int i = 0; i < coordinatesList.size() -1; i++){   
            stroke(colors[i % numColor]);
            strokeWeight(factor * i % numColor);

            float r = lengths[i] / numPoints;
            Coil coil = new Coil(coordinatesList.get(i)[0], coordinatesList.get(i)[1], coordinatesList.get(i + 1)[0], coordinatesList.get(i+1)[1], r/2, r);   
            coil.display();
        }
    }
}

class SpringLineTool extends LineTool{

    public SpringLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    @Override
    public void display() {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //r size 
        if (numPoints > 50) numPoints %= 50;

        List<float[]> coordinatesList = boundary.getCoordinatesList();
          float[] p1;
          float[] p2;
          float[] lengths = new float[coordinatesList.size()];
        
          for (int i = 0; i < coordinatesList.size(); i++){
            p1 = coordinatesList.get(i);
            if (i + 1 == coordinatesList.size()) {
              p2 = coordinatesList.get(0);
            } else {
              p2 = coordinatesList.get(i+1);
            } 
            lengths[i] = dist(p1[0], p1[1], p2[0], p2[1]);
          }

        for (int i = 0; i < coordinatesList.size() -1; i++){   
            stroke(colors[i % numColor]);
            strokeWeight(0);

            float r = lengths[i] / numPoints;
            Coil coil = new Coil(coordinatesList.get(i)[0], coordinatesList.get(i)[1], 
                                coordinatesList.get(i + 1)[0], coordinatesList.get(i+1)[1], r * 2 / 3, r / 2);   
            coil.display();
        }
    }
}

class ChainLineTool extends LineTool {
    public ChainLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    @Override
    public void display() {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //unit size 
        if (numPoints > 50) numPoints %= 50;
         
        // if (min / 3 > max/numPoints || min < max/numPoints) unit = (int)min / 3;
        // unit = (int)max / numPoints; 
        
        //normalized vectors;
        List<float[]> coordinatesList = boundary.getCoordinatesList();
        
        /**test line Array for tracing. this will be included in class.**/
        float[] p1;
        float[] p2;
        float[] lengths = new float[coordinatesList.size()];
        PVector[] vec = new PVector[coordinatesList.size()];
        float min = width; 
        float max = 0;
    
        for (int i = 0; i < coordinatesList.size(); i++){
        p1 = coordinatesList.get(i);
        if (i + 1 == coordinatesList.size()) {
            p2 = coordinatesList.get(0);
        } else {
            p2 = coordinatesList.get(i+1);
        } 
        PVector point1 = new PVector(p1[0], p1[1]);
        PVector point2 = new PVector(p2[0], p2[1]);
        vec[i] = PVector.sub(point2, point1).normalize();
        lengths[i] = dist(p1[0], p1[1], p2[0], p2[1]);
        if (min < lengths[i])  min = lengths[i]; 
        if (max > lengths[i])  max = lengths[i]; 
        }
            
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
        }
    }
}  

class HornLineTool extends LineTool{
    public HornLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    @Override
    public void display() {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, factor/5 + 1);

        //unit size 
        if (numPoints > 50) numPoints %= 50;
        
        //normalized vectors;
        List<float[]> coordinatesList = boundary.getCoordinatesList();
        
        /**test line Array for tracing. this will be included in class.**/
        float[] p1;
        float[] p2;
        float[] lengths = new float[coordinatesList.size()];
        PVector[] vec = new PVector[coordinatesList.size()];
    
        for (int i = 0; i < coordinatesList.size(); i++){
        p1 = coordinatesList.get(i);
        if (i + 1 == coordinatesList.size()) {
            p2 = coordinatesList.get(0);
        } else {
            p2 = coordinatesList.get(i+1);
        } 
        PVector point1 = new PVector(p1[0], p1[1]);
        PVector point2 = new PVector(p2[0], p2[1]);
        vec[i] = PVector.sub(point2, point1).normalize();
        lengths[i] = dist(p1[0], p1[1], p2[0], p2[1]);
        }
            
        for (int i = 0; i < lengths.length; i++){   

            strokeWeight(0);

            float unit = lengths[i] / numPoints;
            PVector position = new PVector(coordinatesList.get(i)[0], coordinatesList.get(i)[1]);
            PVector direction = vec[i];
            
            for (int j = 0; j < numPoints; j++) {
                stroke(colors[j % numColor]);
                PVector currentPoint = PVector.add(position, PVector.mult(direction, j * unit));
                float ang = PVector.angleBetween(direction, currentPoint);

                PVector v = direction.copy();
                if (j % 2 == 0) v.rotate(100);
                else v.rotate(-100);
                
                PVector nextPoint = PVector.add(currentPoint, PVector.mult(v, unit*3));
                line(currentPoint.x, currentPoint.y, nextPoint.x, nextPoint.y);
            } 
        }
    }
}


class PatternTool implements Tool {
    public Boundary boundary;
    public int numPoints;
    public int factor;
    public int numColor;
    public boolean isInside;

    public PatternTool(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside) {
        super();
        this.boundary = boundary;
        this.numPoints = numPoints;
        this.factor = factor;
        this.numColor = numColor;
        this.isInside = isInside;
    }

    public void display() {
        randomSeed(seed);
    }
}

class EllipsePatternTool extends PatternTool {

    public EllipsePatternTool(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside) {
        super(numPoints, factor, numColor, boundary, isInside);
    }

    @Override
    public void display() {
        randomSeed(seed);
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
            int x = (int)random(200, 1000); /****240415*******/
            int y = (int)random(1, 750); /****240415*******/
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            fill(colors[i % numColor]);
            noStroke();
            if (boundary.contains(points[i]) == isInside) {
                ellipse(points[i][0], points[i][1], random(0, width/5), random(0, height/5)); 
            }
            //println(numPoints);
        }
    }
}

class DiagonalPatternTool extends PatternTool {
    public DiagonalPatternTool(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside) {
        super(numPoints, factor, numColor, boundary, isInside);
    }

    @Override
    public void display() {
        randomSeed(seed);
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
            int x = (int)random(200, 1000); /****240415*******/
            int y = (int)random(1, 750);   /****240415*******/
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            if (boundary.contains(points[i]) == isInside) {
                stroke(colors[i % numColor]);
                
                int ang = (int)random(360);
                
                a = points[i][0] + cos(radians(ang))*50;
                b = points[i][1] + sin(radians(ang))*50;
    
                line(points[i][0], points[i][1], a, b);
            }
            
        }
    }
}

class DotsPatternTool extends PatternTool {
    public DotsPatternTool(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside) {
        super(numPoints, factor, numColor, boundary, isInside);
    }

    @Override
    public void display() {
        randomSeed(seed);
        if (numPoints < 500) numPoints *= 1000;
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
            if (boundary.contains(points[i]) == isInside) {
                fill(colors[i % numColor/2]);
                noStroke();
                ellipse(points[i][0], points[i][1], 3, 3); 
            }  
        }
    }
}

class FunTool implements Tool {
    public Boundary boundary;
    public int numPoints;
    public int numColor;
    public boolean isInside;

    public FunTool(int numPoints, int numColor, Boundary boundary, boolean isInside) {
        super();
        this.boundary = boundary;
        this.numPoints = numPoints;
        this.numColor = numColor;
        this.isInside = isInside;
    }

    public void display() {
    }
}

class Noise1FunTool extends FunTool {
    public Noise1FunTool(int numPoints, int numColor, Boundary boundary, boolean isInside) {
            super(numPoints, numColor, boundary, isInside);
        }

    @Override
    public void display() {
        randomSeed(seed);
        if (numPoints < 500) numPoints *= 1000;
        int[][] points = new int[numPoints][2]; 
        
        int minX = 0; 
        int minY = 0; 

        // Position the points randomly, split by Sherry

        for (int i = 0; i < numPoints; i++) {
            int x = (int)random(minX, width); 
            int y = (int)random(minY, height); 
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            fill(200);
            noStroke();
            ellipse(points[i][0], points[i][1], 3, 3); 
        }
    }
}

class Noise2FunTool extends FunTool {
    public Noise2FunTool(int numPoints, int numColor, Boundary boundary, boolean isInside) {
            super(numPoints, numColor, boundary, isInside);
        }

    @Override
    public void display() {
        randomSeed(seed);
        if (numPoints < 500) numPoints *= 1000;
        int[][] points = new int[numPoints][2]; 
        
        int minX = 0; 
        int minY = 0; 

        // Position the points randomly, split by Sherry

        for (int i = 0; i < numPoints; i++) {
            int x = (int)random(minX, width); 
            int y = (int)random(minY, height); 
            points[i][0] = x; 
            points[i][1] = y; 
        }
        
        // Display the points 
        for (int i = 0; i < numPoints; i++) {
            fill(50);
            noStroke();
            ellipse(points[i][0], points[i][1], 3, 3); 
        }
    }
}

class DefaultFunTool extends FunTool {
    public DefaultFunTool(int numPoints, int numColor, Boundary boundary, boolean isInside) {
            super(numPoints, numColor, boundary, isInside);
        }

    @Override
    public void display() {
    }
}

class Color {

    private int numColor;

    public Color(int numColor) {
        this.numColor = numColor;
    }

    public color[] colorBySize(int numColor, int factor) {
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
