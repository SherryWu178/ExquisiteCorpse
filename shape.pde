interface Shape {
    void display();
    void display(DisplayMode mode);
    color getColor();
    void setColor(color c);
    float[] getPosition();
}

// enum DisplayMode {
//     MAIN,
//     WINDOW1,
//     WINDOW2,
//     WINDOW3,
//     WINDOW4,
//     FINAL_DISPLAY
// }

class SohyunLine implements Shape {
    // Getter and setter methods for centerX and centerY
    private List<float[]> coordinatesList = new ArrayList<>();
    private int brushHead;
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
        coordinatesList = new CoordinateTransformer().transformArray(mode, this.coordinatesList);
        for (int i = 0; i < coordinatesList.size() - 1; i++) {
            float[] start = coordinatesList.get(i);
            float[] end = coordinatesList.get(i + 1);
            line(start[0], start[1], end[0], end[1]);
        }
    }

    public void display(DisplayMode mode) {
        stroke(shapeColor);
        strokeWeight(brushHead);
        coordinatesList = new CoordinateTransformer().transformArray(mode, this.coordinatesList);
        for (int i = 0; i < coordinatesList.size() - 1; i++) {
            float[] start = coordinatesList.get(i);
            float[] end = coordinatesList.get(i + 1);
            line(start[0], start[1], end[0], end[1]);
        }
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
}

interface SherryPolygon extends Shape {
    // Getter and setter methods for centerX and centerY
    float getCenterX();
    float getCenterY();
    float[] getPosition();
    
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
}
