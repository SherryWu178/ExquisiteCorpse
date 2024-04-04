interface Shape {
    void display();
}

interface SherryPolygon extends Shape{
}

class Rectangle implements SherryPolygon {
    private float x;
    private float y;
    private float length;
    private float width;

    
    public Rectangle(float x, float y, float length, float width) {
        this.length = length;
        this.width = width;
        this.x = x;
        this.y = y;
    }
    
    @Override
    public void display() {
        rect(this.x, this.y, this.length, this.width);
    }
}

class Circle implements SherryPolygon {
    private float centerX;
    private float centerY;
    private float radius;
    
    public Circle(float centerX, float centerY, float radius) {
        this.centerX = centerX;
        this.centerY = centerY;
        this.radius = radius;
    }
    
    @Override
    public void display() {
        // System.out.println("Circle: Radius = " + radius + ", Center = (" + centerX + ", " + centerY + ")");
        circle(this.centerX, this.centerY, this.radius);
    }
}
