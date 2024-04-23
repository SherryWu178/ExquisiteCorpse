// import ui.*;
import java.util.Random;

int a, b, c, d;
int centerX, centerY, radius;
ArrayList<Shape> shapes = new ArrayList<>();
List<float[]> currentCoordinatesList = new ArrayList<>();
color currentColor = color(0);
int shapeType = 2;
int brushType = 0;
int brushHead = 10;
int currentshapeCompleted = 0;
int needPrompt = 1;
GlobalStage globalStage = GlobalStage.HUMAN_DRAW_1;
ShapeDatabase shapeDatabase = new ShapeDatabase();
PretransformParameters currentPretransformParameters;
Computer computer = new Computer();
int seed;

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
    FINAL_DISPLAY1,
    FINAL_DISPLAY2,
    FINAL_DISPLAY3,
    FINAL_DISPLAY4
}

void setup() {
    size(1200, 750); // 1000 x 750 + (200 x 150) * 4
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    
    smooth();
    seed = (int)random(100);
    frameRate(10);
    ellipseMode(CENTER);

}

// use for testing
void test() {
    // Boundary feet_1 = new Torso1();
    // Boundary feet_2 = new Torso2();
    // Boundary feet_3 = new Torso3();
    // Boundary feet_4 = new Torso4();

    // stroke(0);
    // feet_1.display(DisplayMode.MAIN);
    // stroke(255, 255, 0);
    // feet_2.display(DisplayMode.MAIN);
    // stroke(255, 0, 0);
    // feet_3.display(DisplayMode.MAIN);
    // stroke(0, 0, 255);
    // feet_4.display(DisplayMode.MAIN);
}


void draw() {
    if (globalStage == GlobalStage.FINAL_STAGE) {
        background(150);
    } else {
        background(255);
    }

    shapeDatabase.displayMainCanvas(globalStage);

    rightPanel();
    toolBar();

    // stroke(0);
    // strokeWeight(2);
    noFill();
    
    drawingGuide();
    shapeDatabase.displaySidePanel(globalStage);
    
    // if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
    //     computer.computer_draw(currentGlobalFeature);
// }
    
    // if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
    //     computer.computer_draw(currentGlobalFeature);
// }
    
    if (mouseX > - 1 && mouseX < 125 && mouseY > - 1 && mouseY < 750) {
        // println("Mouse click at toolbar");
    } else {
        if (brushType == 0) brushHead = 10;
        if (brushType == 1) brushHead = 15;
        if (brushType == 2) brushHead = 20;
        if (brushType == 3) brushHead = 5;

        if (currentshapeCompleted == 1) {
            return;
        }
        
        if (shapeType == 0) {
            centerX = a + c / 2;
            centerY = b + d / 2;
            // radius = (c ^ 2 + d ^ 2) ^ 0.5;
            float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
            Circle circle = new Circle(centerX, centerY, radius, currentColor, brushHead);
            stroke(currentColor);
            circle.display();
        }
        
        else if (shapeType == 1) {
            Rectangle rectangle = new Rectangle(a, b, c, d, currentColor, brushHead);
            rectangle.display();
        }
        
        else if (shapeType == 2) {
            stroke(0);
            strokeWeight(10);
            float mx = constrain(mouseX, 120, 1000);
            float my = constrain(mouseY, 0, 750);
            if (mousePressed) {
                currentCoordinatesList.add(new float[] {mx, my});
                // println(currentCoordinatesList);
                SohyunLine line = new SohyunLine(currentCoordinatesList, currentColor, brushHead);
                line.display();
            }        
        }
    }
}

void selectBrush() {
    // Check if mouse click occurred within ellipse region
    if (mouseX > 60 - 17.5 && mouseX < 60 + 17.5 && mouseY > 290 - 17.5 && mouseY < 290  + 17.5) {
        brushType = 0;  
    }
    // Check if mouse click occurred within rect region
    else if (mouseX > 45 && mouseX < 45 + 30 && mouseY > 340 && mouseY < 340 + 30) {
        brushType = 1;  
    }
    // Check if mouse click occurred within triangle region
    else if (mouseX > 45 && mouseX < 75 && mouseY > 380 && mouseY < 390 + 10) {
        brushType = 2;  
    }
    
    println("Brush type: " + brushType);
}

void selectShape() {
    // Check if mouse click occurred within ellipse region
    if (mouseX > 60 - 17.5 && mouseX < 60 + 17.5 && mouseY > 560 - 17.5 && mouseY < 560 + 17.5) {
        shapeType = 0; // Set shapeType to ellipse
    }
    // Check if mouse click occurred within rect region
    else if (mouseX > 45 && mouseX < 45 + 30 && mouseY > 610 && mouseY < 610 + 30) {
        shapeType = 1; // Set shapeType to rect
    }
    // Check if mouse click occurred within triangle region
    else if (mouseX > 45 && mouseX < 75 && mouseY > 670 && mouseY < 695) {
        shapeType = 2; // Set shapeType to triangle
    }
    
    println("Shape type: " + shapeType);
}

void next() {
    
    PretransformParametersExtractor ppe = new PretransformParametersExtractor();
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        currentPretransformParameters = ppe.extract(shapeDatabase, globalStage);
        PImage img_1 = get(125, 0, 875, 750);
        img_1.save("HUMAN_DRAW_1.png");
        globalStage = GlobalStage.COMPUTER_DRAW_2;
        computer.computer_create_style(currentPretransformParameters); 
        needPrompt = 1;
        
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
        // saveFrame("COMPUTER_DRAW_2.png");
        PImage img_2 = get(125, 0, 875, 750);
        img_2.save("COMPUTER_DRAW_2.png");
        globalStage = GlobalStage.HUMAN_DRAW_3;
        needPrompt = 1;
        
    } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
        currentPretransformParameters = ppe.extract(shapeDatabase, globalStage);
        PImage img_3 = get(125, 0, 875, 750);
        img_3.save("HUMAN_DRAW_3.png");
        globalStage = GlobalStage.COMPUTER_DRAW_4;
        seed = (int)random(100);
        computer.computer_create_style(currentPretransformParameters);
        needPrompt = 1;
        
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
        PImage img_4 = get(125, 0, 875, 750);
        img_4.save("COMPUTER_DRAW_4.png");
        globalStage = GlobalStage.FINAL_STAGE;
    }
}

void save() {
    PImage img = get(400, 0, 250, 750);
    String filename = "FINAL_" + str(millis())+ ".png";
    img.save(filename);
}

void reset() {
    shapes = new ArrayList<>();
    currentCoordinatesList = new ArrayList<>();
    globalStage = GlobalStage.HUMAN_DRAW_1;
    shapeDatabase = new ShapeDatabase();
    currentPretransformParameters = null;
    shapeType = 2; 
    seed = (int)random(100);
}

void deletePrevious() {
    shapeDatabase.deletePreviousShape(globalStage);
} 

void keyPressed() {
    int keyIndex = -1;
    if (key == 'R' || key == 'r') {
        println("Reset");  
        reset();
    }

    if (key == 'D' || key == 'd') {
        println("Delete previous shape");
        deletePrevious();
    }
}

void mouseClicked() {
    println("Mouse clicked at: " + mouseX + ", " + mouseY);
    if (mouseX > - 1 && mouseX < 125 && mouseY > 251 && mouseY < 499 + 251) {
        println("Select Shape");
        selectShape();
        selectBrush();
    }
    
    if (mouseX > - 1 && mouseX < 125 && mouseY > - 1 && mouseY < 250) {
        println("Select Color");
        selectColor();
    }
    
    if (mouseX > 1075 && mouseX < 1125 && mouseY > 659 && mouseY < 699) {
        println("Next");
        next();
    }
    
    if (mouseX > 1075 && mouseX < 1125 && mouseY > 710 && mouseY < 750) {
        if (globalStage == GlobalStage.FINAL_STAGE) {
            println("Save");
            save();
        }
    }
}

void mousePressed() {
    if (mouseX > - 1 && mouseX < 125 && mouseY > - 1 && mouseY < 750) {
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
    
    currentshapeCompleted = 0;   
    needPrompt = 0;
}

void mouseReleased() {
    if (mouseX > - 1 && mouseX < 125 && mouseY > - 1 && mouseY < 750) {
        // println("Mouse released at toolbar");
    } else {
        if (brushType == 0) brushHead = 10;
        if (brushType == 1) brushHead = 15;
        if (brushType == 2) brushHead = 20;
        if (brushType == 3) brushHead = 5;
        
        c = mouseX - a;
        d = mouseY - b;
        
        // Add circle
        if (shapeType ==  0) {
            centerX = a + c / 2;
            centerY = b + d / 2;
            // radius = (c ^2 + d ^ 2) ^ 0.5;
            float radius = (float) Math.pow(Math.pow(c, 2) + Math.pow(d, 2), 0.5);
            Circle circle = new Circle(centerX, centerY, radius, currentColor, brushHead);
            shapeDatabase.addShape(circle, globalStage);
        }
        
        // Add rectangle
        else if (shapeType == 1) {
            Rectangle rect = new Rectangle(a, b, c, d, currentColor, brushHead);
            shapeDatabase.addShape(rect, globalStage);
        }
        
        else if (shapeType == 2) { 
            SohyunLine line = new SohyunLine(currentCoordinatesList, currentColor, brushHead);
            shapeDatabase.addShape(line, globalStage);
            currentCoordinatesList = new ArrayList<>();
        }
        
        currentshapeCompleted = 1;
    }
    // println("Mouse released at: " + mouseX + ", " + mouseY);
}
