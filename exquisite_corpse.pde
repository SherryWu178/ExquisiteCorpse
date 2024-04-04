// import ui.*;

int a, b, c, d;
int centerX, centerY, radius;
ArrayList<Shape> shapes = new ArrayList<>();
int shapeType = 0;


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

    if shapeType == 0 {
        ellipse(a + c/2, b + d/2, c, d);
    }
    else if shapeType == 1 {
        rect(a, b, c, d);
    }
    else if shapeType == 2 {
        triangle(a, b, a + c, b, a + c/2, b - d);
    }
}


void selectShape() {
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

// Select shape type
void mouseClicked() {
    selectShape();
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

    // Add circle
   if (shapeType == 0) {
        centerX = a + c/2;
        centerY = b + d/2;
        // radius = (c ^ 2 + d ^ 2) ^ 0.5;
        float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
       Circle circle = new Circle(centerX, centerY, radius);
       shapes.add(circle);
   }
   // Add rectangle
   else if (shapeType == 1) {
       Rectangle rect = new Rectangle(a, b, c, d);
       shapes.add(rect);
   }

   else if (shapeType == 2) { 
   }
   Rectangle rect = new Rectangle(a, b, c, d);
   shapes.add(rect);
  }
  println("Mouse released at: " + mouseX + ", " + mouseY);
}
