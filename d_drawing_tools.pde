interface Tool {
}

class LineTool implements Tool {
    // Fields declaration
    public Boundary boundary;
    public int numPoints;
    public int factor1;
    public int factor2;
    public int numColor;


    // Constructor
    public LineTool(int numPoints, int factor1, int factor2, 
                        int numColor, Boundary boundary) {
        // Assign values to fields
        this.numPoints = numPoints;
        this.factor1 = factor1;
        this.factor2 = factor2;
        this.numColor = numColor;
        this.boundary = boundary;
    }

    public void display() {
        randomSeed(seed);
    }
}

class CoilLineTool extends LineTool {
    public CoilLineTool(int numPoints, int factor1, int factor2, 
                        int numColor, Boundary boundary) {
        super(numPoints, factor1, factor2, numColor, boundary);
    }

    public void display(DisplayMode mode) {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, factor1/5 + 1);

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
            float r = lengths[i] / numPoints; 
            stroke(colors[i % numColor]);
            if (r > 10) strokeWeight(1);
            else strokeWeight(i % 5);   

            Coil coil = new Coil(coordinatesList.get(i)[0], coordinatesList.get(i)[1], 
                                coordinatesList.get(i + 1)[0], coordinatesList.get(i+1)[1], r/2, r);   
            coil.display();
        }
    }
}

class SpringLineTool extends LineTool{
    public SpringLineTool(int numPoints, int factor1, int factor2, 
                        int numColor, Boundary boundary){
        super(numPoints, factor1, factor2, numColor, boundary);
    }

    @Override
    public void display() {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, factor1/5 + 1);

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
            float r = lengths[i]/random(1, 10);
            stroke(colors[i % numColor]);
            strokeWeight(1); 

            Coil coil = new Coil(coordinatesList.get(i)[0], coordinatesList.get(i)[1], 
                                coordinatesList.get(i + 1)[0], coordinatesList.get(i+1)[1], r * 2 / 3, r / 2);   
            coil.display();
        }
    }
}

class ChainLineTool extends LineTool {
    private int stroke;
    private int transp;
    private int radius;

    public ChainLineTool(int numPoints, int factor1, int factor2, 
                        int numColor, Boundary boundary, int stroke, int transp, int radius) {
        super(numPoints, factor1, factor2, numColor, boundary);
        this.stroke = stroke;
        this.transp = transp;
        this.radius = radius;
    }

    @Override
    public void display() {
        randomSeed(seed);
        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, factor1/5 + 1);

        //unit size 
        if (numPoints > 50) numPoints %= 50;
        if (numPoints < 10) numPoints *= 100;    

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

        //chain generator
        for (int i = 0; i < lengths.length; i++){  
            stroke(colors[i % numColor]);
            
            if (stroke % 2 == 0) strokeWeight(1);
            else strokeWeight(i % 3);

            float unit = lengths[i] / numPoints;
            PVector position = new PVector(coordinatesList.get(i)[0], coordinatesList.get(i)[1]);
            PVector direction = vec[i];
            
            for (int j = 0; j < numPoints; j++) {
                //opacity 
                int opa;
                if (transp % 3 == 0) opa = 0;
                else opa = 1;
                fill(colors[j % numColor], opa);

                //factor2
                if (factor2 % 3 == 0) { //divide by point number
                    PVector currentPoint = PVector.add(position, 
                                                        PVector.mult(direction, j * unit));
                    
                    ellipse(currentPoint.x, currentPoint.y, 
                            radius * j % 50 , radius * j % 50);
                } else if (factor2 % 3 == 1) { //divide by point number
                    unit = lengths[i] % numPoints; 
                    PVector currentPoint = PVector.add(position, 
                                                        PVector.mult(direction, j * unit));
                    
                    ellipse(currentPoint.x, currentPoint.y, 
                            radius * j % 50 , radius * j % 50);
                
                } else { //divide by length
                    unit = radius % 50;
                    float overlap = 0.5;
        
                    PVector currentPoint = PVector.add(position, 
                                                        PVector.mult(direction, overlap * j * unit));
                    float distanceFromStart = PVector.dist(position, currentPoint); 
                    if(distanceFromStart > lengths[i]) break; 
                    
                    ellipse(currentPoint.x, currentPoint.y, radius % 300, radius % 300 );
                } 
            }
        }
    }
}  

class HornLineTool extends LineTool{
    public int stroke;
    public int angle;
    
    public HornLineTool(int numPoints, int factor1, int factor2, 
                        int numColor, Boundary boundary, 
                        int stroke, int angle) {
        super(numPoints, factor1, factor2, numColor, boundary);
        this.stroke = stroke;
        this.angle = angle;
    }

    @Override
    public void display() {
        randomSeed(seed);

        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, factor1/5 + 1);

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

        //draw base
        for (int i = 0; i < lengths.length - 1; i++) {
            strokeWeight(1);
            stroke(colors[i % numColor], 128); //transparency 128
            line(coordinatesList.get(i)[0], coordinatesList.get(i)[1], 
                coordinatesList.get(i + 1)[0], coordinatesList.get(i + 1)[1]);
        } 

        //draw horn
        for (int i = 0; i < lengths.length; i++){   
            int count;
            if (stroke % 2 == 0) strokeWeight(0);
            else strokeWeight(i % 5);

            if (stroke % 2 == 0) count = numPoints % 50;
            else count = numPoints % 25;
            float unit = lengths[i] / count;

            PVector position = new PVector(coordinatesList.get(i)[0], coordinatesList.get(i)[1]);
            PVector direction = vec[i];
            
            for (int j = 0; j < count; j++) {
                stroke(colors[j % numColor]);
                PVector currentPoint = PVector.add(position, PVector.mult(direction, j * unit));
                float ang = PVector.angleBetween(direction, currentPoint);
                
                int rotation = angle % 360;
                PVector v = direction.copy();
                if (j % 2 == 0) v.rotate(rotation);
                else v.rotate(-rotation);
                
                PVector nextPoint = PVector.add(currentPoint, PVector.mult(v, factor2 * unit % 200));
                line(currentPoint.x, currentPoint.y, nextPoint.x, nextPoint.y);
            } 
        }
    }
}


class PatternTool implements Tool {
    public Boundary boundary;
    public int numPoints;
    public int factor1;
    public int factor2;
    public int numColor;
    public boolean isInside;
    public int angle;
    public int stroke;
    public int transp;

    public PatternTool(int numPoints, int factor1, int factor2, int numColor, 
                        Boundary boundary, boolean isInside) {
        super();
        this.boundary = boundary;
        this.numPoints = numPoints;
        this.factor1 = factor1;
        this.factor2 = factor1;
        this.numColor = numColor;
        this.isInside = isInside;
    }

    public void display() {
        randomSeed(seed);
    }
}

class EllipsePatternTool extends PatternTool {

    public EllipsePatternTool(int numPoints, int factor1, int factor2, int numColor, 
                            Boundary boundary, boolean isInside, 
                            int angle, int stroke, int transp) {
        super(numPoints, factor1, factor2, numColor, boundary, isInside);
        this.angle = angle;
        this.stroke = stroke;
        this.transp = transp;
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
        color[] colors = colorC.colorBySize(numColor, 1, 2);
        
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
            noStroke();
            if (boundary.contains(points[i]) == isInside) {
                ellipse(points[i][0], points[i][1], random(0, width/5), random(0, height/5)); 
            }

        }

        for (int i = 0; i < numPoints; i++) {
            pushMatrix();
            int opa;
            float radiusW;
            float radiusH;
            if (transp % 3 == 0) opa = 0;
            else opa = 1;
            fill(colors[i % numColor], opa);

            if (stroke % 3 == 0) strokeWeight(i % 3);
            else strokeWeight(0);

            if (factor1 % 4 == 0) {
                rotate(0);
            } else {
                rotate(radians(angle * i % 360));
            }

            if (factor2 % 2 == 0) {
                radiusW = random(0, width/5);
                radiusH = random(0, height/5);
            } else {
                radiusW = 20;
                radiusH = 50;
            }

            ellipse(points[i][0], points[i][1], radiusW, radiusH); 
            popMatrix();
        }
    }
}

class DiagonalPatternTool extends PatternTool {
    public DiagonalPatternTool(int numPoints, int factor1, int factor2, int numColor, 
                                Boundary boundary, boolean isInside) {
        super(numPoints, factor1, factor2, numColor, boundary, isInside);
    }

    @Override
    public void display() {
        randomSeed(seed);
        if (numPoints % 2 == 0) numPoints *= 100;
        else if (numPoints < 50) numPoints *= 100;

        int[][] points = new int[numPoints][2]; 
        
        float a;
        float b;
        int minX = 0; 
        int minY = 0; 

        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, factor1/30 + 1);

        
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
                int length;
                if (factor2 % 2 == 0) strokeWeight(0);
                else strokeWeight(i/10);
                
                int ang = (int)random(360);

                if (factor2 % 5 == 0) length = (int)random(10, factor2);
                else length = i % factor2 + 10;
                
                a = points[i][0] + cos(radians(ang))*length;
                b = points[i][1] + sin(radians(ang))*length;
    
                line(points[i][0], points[i][1], a, b);
            }
            
        }
    }
}

class DotsPatternTool extends PatternTool {
    public DotsPatternTool(int numPoints, int factor1, int factor2, int numColor, 
                            Boundary boundary, boolean isInside) {
        super(numPoints, factor1, factor2, numColor, boundary, isInside);
    }

    @Override
    public void display() {
        randomSeed(seed);
        if (numPoints % 2 == 0) numPoints *= 400;
        else if (numPoints < 100) numPoints *= 100;
        int[][] points = new int[numPoints][2]; 
        
        int minX = 0; 
        int minY = 0; 

        //color random generator
        Color colorC = new Color(numColor);
        color[] colors = colorC.colorBySize(numColor, 1, 1);

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

    public FunTool(int numPoints, int numColor, Boundary boundary, 
                    boolean isInside) {
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
    public Noise1FunTool(int numPoints, int numColor, Boundary boundary,   
                        boolean isInside) {
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
            fill(200, 3);
            noStroke();
            ellipse(points[i][0], points[i][1], 3, 3); 
        }
    }
}

class Noise2FunTool extends FunTool {
    public Noise2FunTool(int numPoints, int numColor, Boundary boundary, 
                        boolean isInside) {
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
            fill(50, 3);
            noStroke();
            ellipse(points[i][0], points[i][1], 3, 3); 
        }
    }
}

class DefaultFunTool extends FunTool {
    public DefaultFunTool(int numPoints, int numColor, Boundary boundary, 
                        boolean isInside) {
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

    public color[] colorBySize(int numColor, int factor1, int factor2) {
        color[] colors = new color[numColor]; 
        
        int minSize = 5/factor1; 
        int maxSize = 255/factor2;
        
        for (int i = 0; i < numColor; i++) {
            int r = (int)random(minSize, maxSize); 
            int g = (int)random(minSize, maxSize); 
            int b = (int)random(minSize, maxSize); 
            colors[i] = color(r, g, b);
        }
        return colors;
    }
}
