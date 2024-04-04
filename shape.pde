interface Shape {
    void display();
    color getColor();
    void setColor(color c);
}

interface SherryPolygon extends Shape {}

class Rectangle implements SherryPolygon {
    private float x;
    private float y;
    private float length;
    private float width;
    private color shapeColor; // Changed attribute name to shapeColor
    
    public Rectangle(float x, float y, float length, float width, color shapeColor) {
        this.x = x;
        this.y = y;
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
    public color getColor() {
        return shapeColor;
    }
    
    @Override
    public void setColor(color newColor) {
        this.shapeColor = newColor;
    }
}

class Circle implements SherryPolygon {
    private float centerX;
    private float centerY;
    private float radius;
    private color shapeColor; // Changed attribute name to shapeColor
    
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
    public color getColor() {
        return shapeColor;
    }
    
    @Override
    public void setColor(color newColor) {
        this.shapeColor = newColor;
    }
}
