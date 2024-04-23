interface Shape {
    void display();
    void display(DisplayMode mode);
    color getColor();
    void setColor(color c);
    float[] getPosition();
    float getLength();
}


class SohyunLine implements Shape {
    // Getter and setter methods for centerX and centerY
    private List<float[]> coordinatesList;
    private Integer brushHead;
    private color shapeColor;

    public SohyunLine(List<float[]> coordinatesList, color shapeColor, int brushHead) {
        this.coordinatesList = coordinatesList;
        this.shapeColor = shapeColor;
        this.brushHead = brushHead;
    }

    @Override
    public void display() {
        DisplayMode mode = DisplayMode.MAIN;
        stroke(shapeColor);
        strokeWeight(brushHead);
        List<float[]> transformedCoordinates = new CoordinateTransformer().transformArray(mode, this.coordinatesList);
        for (int i = 0; i < transformedCoordinates.size() - 1; i++) {
            float[] start = transformedCoordinates.get(i);
            float[] end = transformedCoordinates.get(i + 1);
            line(start[0], start[1], end[0], end[1]);
        }
    }

    public void display(DisplayMode mode) {
        stroke(shapeColor);
        strokeWeight(brushHead);
        CoordinateTransformer transformer = new CoordinateTransformer();
        transformer.transformSohyunLine(this.coordinatesList, mode);
        print("I am displaying line\n");
    }

    @Override
    public color getColor() {
        return shapeColor;
    }

    @Override
    public void setColor(color newColor) {
        this.shapeColor = newColor;
    }

    @Override
    public float[] getPosition() {
        float sumX = 0;
        float sumY = 0;
        for (float[] coordinate : coordinatesList) {
            sumX += coordinate[0];
            sumY += coordinate[1];
        }
        return new float[] {sumX / coordinatesList.size(), sumY / coordinatesList.size()};
    }

    @Override
    public float getLength() {
        if (coordinatesList.isEmpty()) {
            return 0; // If there are no points, the length is zero
        }

        float[] startPoint = coordinatesList.get(0);
        float[] endPoint = coordinatesList.get(coordinatesList.size() - 1);

        float dx = endPoint[0] - startPoint[0];
        float dy = endPoint[1] - startPoint[1];

        return sqrt(dx * dx + dy * dy);
    }
}

interface SherryPolygon extends Shape {
    // Getter and setter methods for centerX and centerY
    float getCenterX();
    float getCenterY();
    float[] getPosition();
    float getLength();
}

class Rectangle implements SherryPolygon {
    private float x;
    private float y;
    private float length;
    private float width;
    private color shapeColor; 
    private float centerX;
    private float centerY;
    private int brushHead;
    
    public Rectangle(float x, float y, float length, float width, color shapeColor, int brushHead) {
        this.x = x;
        this.y = y;
        this.centerX = x + length / 2;
        this.centerY = y + width / 2;
        this.length = length;
        this.width = width;
        this.shapeColor = shapeColor;
        this.brushHead = brushHead;
    }
    
    @Override
    public void display() {
        stroke(shapeColor);
        strokeWeight(brushHead);
        rect(x, y, length, width);
    }

    @Override
    public void display(DisplayMode mode) {
        stroke(shapeColor);
        strokeWeight(brushHead);
        CoordinateTransformer transformer = new CoordinateTransformer();
        transformer.transformRectangle(x, y, length, width, mode);
    }
    
    @Override
    public color getColor() {
        return shapeColor;
    }
    
    @Override
    public void setColor(color newColor) {
        this.shapeColor = newColor;
    }

    @Override
    public float getCenterX() {
        return centerX;
    }

    @Override
    public float getCenterY() {
        return centerY;
    }   

    @Override
    public float[] getPosition() {
        return new float[] {centerX, centerY};
    }

    @Override
    public float getLength() {
        return max(length, width);
    }

}

class Circle implements SherryPolygon {
    private float radius;
    private color shapeColor; 
    private float centerX;
    private float centerY;
    private int brushHead;

    public Circle(float centerX, float centerY, float radius, color shapeColor, int brushHead) {
        this.centerX = centerX;
        this.centerY = centerY;
        this.radius = radius;
        this.shapeColor = shapeColor;
        this.brushHead = brushHead;
    }
    
    @Override
    public void display() {
        stroke(shapeColor);
        strokeWeight(brushHead);
        circle(centerX, centerY, radius);
    }
    
    @Override
    public void display(DisplayMode mode) {
        stroke(shapeColor);
        strokeWeight(brushHead);
        CoordinateTransformer transformer = new CoordinateTransformer();
        transformer.transformCircle(centerX, centerY, radius, mode);
    }

    @Override
    public color getColor() {
        return shapeColor;
    }
    
    @Override
    public void setColor(color newColor) {
        this.shapeColor = newColor;
    }

    @Override
    public float getCenterX() {
        return centerX;
    }  

    @Override
    public float getCenterY() {
        return centerY;
    }

    @Override
    public float[] getPosition() {
        return new float[] {centerX, centerY};
    }

    @Override  
    public float getLength() {
        return radius*2;
    }
}
