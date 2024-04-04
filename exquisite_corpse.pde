int a, b, c, d;
int centerX, centerY, radius;
ArrayList<Shape> shapes = new ArrayList<>();
int shapeType = 0;

interface Shape {
    // Method to display shape information
    void display();
}

class Rectangle implements Shape {
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

class Circle implements Shape {
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


void toolBar() {
  //Draw background of toolbar
  fill(150);
  strokeWeight(1);
  rect (-1, -1, 125, 250);
  
  
  fill(150);
  strokeWeight(1);
  rect (-1, 249, 125, 251);
  
  fill(150);
  strokeWeight(1);
  rect (-1, 499, 125, 251);

  
  //Draw color selections
  stroke(0);
  strokeWeight(2);
  fill(183,24,24);
  ellipse (20, 20, 25, 25);
  fill(255,13,13);
  ellipse (60, 20, 25, 25);
  fill(240,41,157);
  ellipse (100, 20, 25, 25);
  fill(236,41,240);
  ellipse (20, 60, 25, 25);
  fill(169,41,240);
  ellipse (60, 60, 25, 25);
  fill(116,41,240);
  ellipse (100, 60, 25, 25);
  fill(24,22,240);
  ellipse (20, 100, 25, 25);
  fill(22,194,240);
  ellipse (60, 100, 25, 25);
  fill(22,240,187);
  ellipse (100, 100, 25, 25);
  fill(51,229,52);
  ellipse (20, 140, 25, 25);
  fill(225,245,79);
  ellipse (60, 140, 25, 25);
  fill(255,244,31);
  ellipse (100, 140, 25, 25);
  fill(255,157,52);
  ellipse (20, 180, 25, 25);
  fill(234,210,147);
  ellipse (60, 180, 25, 25);
  fill(131,114,70);
  ellipse (100, 180, 25, 25);
  fill (255);
  ellipse (20, 220, 25, 25);
  fill (175);
  ellipse (60, 220, 25, 25);
  fill (0);
  ellipse (100, 220, 25, 25);
  
  //Draw line thickness selections
  ellipse (60, 295, 5, 5);
  ellipse (60, 325, 10, 10);
  ellipse (60, 360, 15, 15);
  ellipse (60, 400, 25, 25);
  ellipse (60, 450, 35, 35);
  
  //Draw shape selections
  ellipse (60, 545, 35, 35);
  rect (45, 585, 30, 30);
  triangle(60, 640, 45, 665, 75, 665);
}

void setup() {
  size(500, 750);
  a=0;
  b=0;
  c=0;
  d=0;
}


void draw() {
  background(0);
  toolBar();
  stroke(255);
  strokeWeight(2);
  noFill();
  for (Shape shape : shapes) {
        shape.display();
    }
    rect(a, b, c, d);
}

void mouseClicked() {
    println("Mouse clicked at: " + mouseX + ", " + mouseY);
  // Check if mouse click occurred within ellipse region
  if (mouseX > 60 - 17.5 && mouseX < 60 + 17.5 && mouseY > 545 - 17.5 && mouseY < 545 + 17.5) {
    shapeType = 0; // Set shapeType to ellipse
  }
  // Check if mouse click occurred within rect region
  else if (mouseX > 45 && mouseX < 45 + 30 && mouseY > 585 && mouseY < 585 + 30) {
    shapeType = 1; // Set shapeType to rect
  }
  // Check if mouse click occurred within triangle region
  else if (mouseX > 45 && mouseX < 75 && mouseY > 640 && mouseY < 665) {
    shapeType = 2; // Set shapeType to triangle
  }

  println("Shape type: " + shapeType);
}

void mousePressed() {
  if (true) {
   a=mouseX;
   b=mouseY;
  }

}


void mouseDragged() {
  if (true) {
   c=mouseX-a;
   d=mouseY-b;
//    rect(a, b, c, d);
//    Rectangle rect = new Rectangle(a, b, c, d);
//    shapes.add(rect);
  }
}

void mouseReleased() {
  if (true) {
   c=mouseX-a;
   d=mouseY-b;
   if (shapeType == 0) {
        centerX = a + c/2;
        centerY = b + d/2;
        // radius = (c ^ 2 + d ^ 2) ^ 0.5;
        float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
       Circle circle = new Circle(centerX, centerY, radius);
       shapes.add(circle);
   }
   else if (shapeType == 1) {
       Rectangle rect = new Rectangle(a, b, c, d);
       shapes.add(rect);
   }
   else if (shapeType == 2) {
       // Add triangle
   }
   Rectangle rect = new Rectangle(a, b, c, d);
   shapes.add(rect);
  }
  println("Mouse released at: " + mouseX + ", " + mouseY);
}
