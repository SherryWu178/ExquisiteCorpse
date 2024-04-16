// import ui.*;

int a, b, c, d;
int centerX, centerY, radius;
ArrayList<Shape> shapes = new ArrayList<>();
List<float[]> currentCoordinatesList = new ArrayList<>();
color currentColor = color(255);
int shapeType = 0;
ArrayList<Boundary> computerShapes = new ArrayList<>();
GlobalStage globalStage = GlobalStage.HUMAN_DRAW_1;

enum GlobalStage {
    HUMAN_DRAW_1,
    COMPUTER_DRAW_2,
    HUMAN_DRAW_3,
    COMPUTER_DRAW_4,
    FINAL_STAGE
} 

enum DisplayMode {
    MAIN,
    WINDOW1,
    WINDOW2,
    WINDOW3,
    WINDOW4,
    FINAL_DISPLAY
}

void setup() {
    size(1200, 750); // 1000 x 750 + (200 x 150) * 4
    a = 0;
    b = 0;
    c = 0;
    d = 0;
}


void draw() {
    background(0);
    toolBar();
    RightPanel();
    stroke(255);
    strokeWeight(2);
    noFill();
    
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        for (Shape shape : shapes) {
            shape.display();
        }    
    }

    else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {

        for (Shape shape : shapes) {
            shape.display(DisplayMode.WINDOW1);
        }

        Boundary torsoBoundary = new Torso1();
        computerShapes.add(torsoBoundary);
        for (Boundary shape : computerShapes) {
            shape.display(DisplayMode.MAIN);
        }  
    }

    
    if (mouseX > -1 && mouseX < 125 && mouseY > -1 && mouseY < 750) {
            // println("Mouse click at toolbar");
    } else {
        if (shapeType == 0) {
            centerX = a + c / 2;
            centerY = b + d / 2;
            // radius = (c ^ 2 + d ^ 2) ^ 0.5;
            float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
            Circle circle = new Circle(centerX, centerY, radius, currentColor);
            stroke(currentColor);
            circle.display();
        }

        else if (shapeType == 1) {
            Rectangle rectangle = new Rectangle(a, b, c, d, currentColor);
            rectangle.display();
        }

        else if (shapeType == 2) {
            stroke(255);
            strokeWeight(5);
            if(mousePressed) {
                currentCoordinatesList.add(new float[] {mouseX, mouseY});
                // println(currentCoordinatesList);
                SohyunLine line = new SohyunLine(currentCoordinatesList, currentColor);
                line.display();
            }        
        }
    }
}


void selectShape() {
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



void mouseClicked() {
	println("Mouse clicked at: " + mouseX + ", " + mouseY);
	if (mouseX > -1 && mouseX < 125 && mouseY > 251 && mouseY < 499 + 251) {
		println("Select Shape");
    	selectShape();
	}

	if (mouseX > -1 && mouseX < 125 && mouseY > -1 && mouseY < 250) {
		println("Select Color");
		selectColor();
	}

    if (mouseX > 35 && mouseX < 85 && mouseY > 679 && mouseY < 719) {
        println("Next");
        GlobalFeatureExtractor gfe = new GlobalFeatureExtractor();
        gfe.extract(shapes);
        if (globalStage == GlobalStage.HUMAN_DRAW_1) {
            globalStage = GlobalStage.COMPUTER_DRAW_2;
        } else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
            globalStage = GlobalStage.HUMAN_DRAW_3;
        } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
            globalStage = GlobalStage.COMPUTER_DRAW_4;
        } else if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
            globalStage = GlobalStage.FINAL_STAGE;
        }
    }
}

void mousePressed() {
    if (mouseX > -1 && mouseX < 125 && mouseY > -1 && mouseY < 750) {
        // println("Mouse click at toolbar");
    } else {
        a = mouseX;
        b = mouseY;
    }    
}

void mouseDragged() {
    if (true) {
        c = mouseX - a;
        d = mouseY - b;
        //    rect(a, b, c, d);
        //    Rectangle rect = new Rectangle(a, b, c, d);
        //    shapes.add(rect);
    }
}

void mouseReleased() {
    if (mouseX > -1 && mouseX < 125 && mouseY > -1 && mouseY < 750) {
        // println("Mouse released at toolbar");
    } else {
        c = mouseX - a;
        d = mouseY - b;
        
        // Add circle
        if (shapeType ==  0) {
            centerX = a + c / 2;
            centerY = b + d / 2;
            // radius = (c ^2 + d ^ 2) ^ 0.5;
            float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
            Circle circle = new Circle(centerX, centerY, radius, currentColor);
            shapes.add(circle);
        }
        // Add rectangle
        else if (shapeType == 1) {
            Rectangle rect = new Rectangle(a, b, c, d, currentColor);
            shapes.add(rect);
        }
        
        else if (shapeType == 2) { 
            SohyunLine line = new SohyunLine(currentCoordinatesList, currentColor);
            shapes.add(line);
            currentCoordinatesList = new ArrayList<>();
        }
    }
    // println("Mouse released at: " + mouseX + ", " + mouseY);
}
