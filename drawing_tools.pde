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
        // Method implementation
    }
}


class CoilLineTool extends LineTool {
    public CoilLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    public void display(DisplayMode mode) {
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
            coil.display(mode);
        }
    }

    @Override
    public void display() {
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

class ChainLineTool extends LineTool {
    public ChainLineTool(int numPoints, int factor, int numColor, Boundary boundary) {
        super(numPoints, factor, numColor, boundary);
    }

    @Override
    public void display() {
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
            // PVector endPos = PVector.add(position, PVector.mult(direction, unit));
            // line(pos[i][0], pos[i][1], endPos.x, endPos.y);
        }

        // a = points[i][0] + cos(radians(ang))*50;
        // b = points[i][1] + sin(radians(ang))*50;
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
    }
}

class EllipsePatternTool extends PatternTool {

    public EllipsePatternTool(int numPoints, int factor, int numColor, Boundary boundary, boolean isInside) {
        super(numPoints, factor, numColor, boundary, isInside);
    }

    @Override
    public void display() {
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