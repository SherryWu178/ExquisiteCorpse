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
    private List<float[]> coordinatesList;
    private Integer brushHead;
    private color shapeColor;

    public SohyunLine(List<float[]> coordinatesList, color shapeColor) {
        print("SohyunLine constructor", coordinatesList.size() );
        this.coordinatesList = coordinatesList;
        this.shapeColor = shapeColor;
    }

    @Override
    public void display() {
        DisplayMode mode = DisplayMode.MAIN;
        stroke(shapeColor);
        strokeWeight(2);
        List<float[]> transformedCoordinates = new CoordinateTransformer().transformArray(mode, this.coordinatesList);
        for (int i = 0; i < transformedCoordinates.size() - 1; i++) {
            float[] start = transformedCoordinates.get(i);
            float[] end = transformedCoordinates.get(i + 1);
            line(start[0], start[1], end[0], end[1]);
        }
    }

    public void display(DisplayMode mode) {
        print("display line..");
        stroke(255);
        strokeWeight(2);
        CoordinateTransformer transformer = new CoordinateTransformer();
        transformer.transformSohyunLine(this.coordinatesList, mode);
        // for (int i = 0; i < new_coordinatesList.size() - 1; i++) {
        //     float[] start = new_coordinatesList.get(i);
        //     float[] end = new_coordinatesList.get(i + 1);
        //     if (start[0] == end[0] && start[1] == end[1]) {
        //         continue;
        //     }
        //     print("start: ", i, "end: ", i+1);
        //     line(start[0], start[1], end[0], end[1]);
        // }
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
    
    public Rectangle(float x, float y, float length, float width, color shapeColor) {
        this.x = x;
        this.y = y;
        this.centerX = x + length / 2;
        this.centerY = y + width / 2;
        this.length = length;
        this.width = width;
        this.shapeColor = shapeColor;
    }
    
    @Override
    public void display() {
        stroke(shapeColor);
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

    public Circle(float centerX, float centerY, float radius, color shapeColor) {
        this.centerX = centerX;
        this.centerY = centerY;
        this.radius = radius;
        this.shapeColor = shapeColor;
    }
    
    @Override
    public void display() {
        stroke(shapeColor);
        circle(centerX, centerY, radius);
    }
    
    @Override
    public void display(DisplayMode mode) {
        print("display circle..");
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
