void drawingGuide() {
    
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        // to get variable
        Boundary torso = new Torso1();
        stroke(255, 0, 0);
        circle(torso.neck1, 745, 5);
        circle(torso.neck2, 745, 5);
    } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
        Boundary feet = new Feet1();
        stroke(255, 0, 0);
        circle(feet.torso1, 5, 5);
        circle(feet.torso2, 5, 5);
        circle(feet.leg1, 745, 5);
        circle(feet.leg2, 745, 5);
        circle(feet.leg3, 745, 5);
        circle(feet.leg4, 745, 5);
    }
}

void toolBar() {
    //Draw background of toolbar
    fill(255);
    
    drawColorSelections();    
    drawShapeSelections();
    drawbrush(); 

    drawNext();
    drawCurrentStage(); 

    if (needPrompt == 1) {
        drawPrompt();
    }
}

void rightPanel() {
    //Draw background of toolbar
    stroke(0);
    strokeWeight(1);
    rect(1000, -1, 200, 750);
    
    fill(255);
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        fill(100);
        rect(1000, 150, 200, 150); // WINDOW2
        rect(1000, 300, 200, 150); // WINDOW3
        rect(1000, 450, 200, 150); // WINDOW4
        
        fill(255);
        strokeWeight(3);
        rect(1000, 0, 200, 150); // WINDOW1
        strokeWeight(1);

    } else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
        fill(100);
        
        rect(1000, 300, 200, 150); // WINDOW3
        rect(1000, 450, 200, 150); // WINDOW4

        fill(255);

        rect(1000, 0, 200, 150); // WINDOW1

        strokeWeight(3);
        rect(1000, 150, 200, 150); // WINDOW2
        strokeWeight(1);
        
    } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
        fill(100);
        rect(1000, 450, 200, 150); // WINDOW4

        fill(255);

        rect(1000, 0, 200, 150); // WINDOW1
        rect(1000, 150, 200, 150); // WINDOW2

        strokeWeight(3);
        rect(1000, 300, 200, 150); // WINDOW3
        strokeWeight(1);

    } else if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
        rect(1000, 0, 200, 150); // WINDOW1
        rect(1000, 150, 200, 150); // WINDOW2
        rect(1000, 300, 200, 150); // WINDOW3

        strokeWeight(3);
        rect(1000, 450, 200, 150); // WINDOW4
        strokeWeight(1);

    } else {
        rect(1000, 0, 200, 150); // WINDOW1
        rect(1000, 150, 200, 150); // WINDOW2
        rect(1000, 300, 200, 150); // WINDOW3
        rect(1000, 450, 200, 150); // WINDOW4
    }


    fill(20);
    rect(1000, 600, 200, 150); // Bottom
    
}


void drawNext() {
    fill(255);
    strokeWeight(1);
    rect(1075, 659, 50, 30);
    
    fill(0);
    textSize(20);
    text("Next", 1080, 680);


    
    if (globalStage == GlobalStage.FINAL_STAGE) {
        fill(255);
        strokeWeight(1);
        rect(1075, 700, 50, 30);

        fill(0);
        textSize(20);
        text("Save", 1080, 720);
    }
}

void drawCurrentStage() {

    String displayText = "";
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        displayText = "Stage 1";
        text(displayText, 1010, 30);
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
        displayText = "Stage 2";
        text(displayText, 1010, 180);
    } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
        displayText = "Stage 3";
        text(displayText, 1010, 330);
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
        displayText = "Stage 4";
        text(displayText, 1010, 480);
    } else if (globalStage == GlobalStage.FINAL_STAGE) {
        displayText = "Final Display";
        text(displayText, 150, 30);
    }
    // fill(0);
    // text(displayText, 10, 730);
}

void drawPrompt() {
    String displayText = "";
    if (globalStage == GlobalStage.HUMAN_DRAW_1) {
        displayText = "Stage 1: It is your turn now! Draw the head and neck and click \"Next\" to proceed.";
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_2) {
        displayText = "Stage 2";
    } else if (globalStage == GlobalStage.HUMAN_DRAW_3) {
        displayText = "Stage 3: It is your turn again! Draw the glute and thighs and click \"Next\" to proceed.";
    } else if (globalStage == GlobalStage.COMPUTER_DRAW_4) {
        displayText = "Stage 4";
    } else if (globalStage == GlobalStage.FINAL_STAGE) {
        // displayText = "Final Display";
    }
    fill(0);
    textSize(15);  
    text(displayText, 130, 20); 
}
    

void drawThichnessSelection() {	    
    fill(150);
    strokeWeight(1);
    rect( -1, 249, 125, 251);
    
    //Drawline thickness selections
      fill(0);
    ellipse(60, 295, 5, 5);
    ellipse(60, 325, 10, 10);
    ellipse(60, 360, 15, 15);
    ellipse(60, 400, 25, 25);
    ellipse(60, 450, 35, 35);
}

void drawbrush() { //palette
    fill(255);
    strokeWeight(1);
    rect(-1, 249, 125, 251);
    
    stroke(0);
    strokeWeight(2);
    
    //Draw brush ellipses
    fill(0);
    ellipse(60, 290, 10, 10);
    ellipse(60, 340, 15, 15);
    ellipse(60, 390, 20, 20);
    
    fill(color(255,0,0));
    stroke(color(255,0,0));
    ellipse(60, 440, 15, 15);
    stroke(0);
}

void drawShapeSelections() { //palette
    
    fill(255);
    strokeWeight(1);
    rect( -1, 499, 125, 251);
    
    stroke(0);
    strokeWeight(2);
    
    //Draw shape ellipses
    fill(255);
    ellipse(60, 560, 35, 35); // Circle
    
    fill(255);
    rect(45, 610, 30, 30); // Square
    
    fill(0);
    strokeWeight(3);
    line(53, 685, 60, 680); //polylines
    line(60, 680,  65, 685);
    line(65, 685,  72, 680);
    
    // beginShape();
    // vertex(45, 625); // first point
    // bezierVertex(25, 25, 100, 50, 50, 100);
    // bezierVertex(20, 130, 75, 140, 120, 120);
    // endShape();
    // fill(255);
    // triangle(60, 640, 45, 665, 75, 665); // Triangle
}

void drawColorSelections() {
    stroke(0);
    strokeWeight(1);
    rect( -1, -1, 125, 250);
    
    stroke(0);
    strokeWeight(2);
    
    //Draw color ellipses
    fill(183, 24, 24);
    ellipse(20, 20, 25, 25); // Red
    fill(255, 13, 13);
    ellipse(60, 20, 25, 25); // Light Red
    fill(240, 41, 157);
    ellipse(100, 20, 25, 25); // Pink
    fill(236, 41, 240);
    ellipse(20, 60, 25, 25); // Light Purple
    fill(169, 41, 240);
    ellipse(60, 60, 25, 25); // Purple
    fill(116, 41, 240);
    ellipse(100, 60, 25, 25); // Dark Purple
    fill(24, 22, 240);
    ellipse(20, 100, 25, 25); // Blue
    fill(22, 194, 240);
    ellipse(60, 100, 25, 25); // Light Blue
    fill(22, 240, 187);
    ellipse(100, 100, 25, 25); // Cyan
    fill(51, 229, 52);
    ellipse(20, 140, 25, 25); // Green
    fill(225, 245, 79);
    ellipse(60, 140, 25, 25); // Yellow Green
    fill(255, 244, 31);
    ellipse(100, 140, 25, 25); // Yellow
    fill(255, 157, 52);
    ellipse(20, 180, 25, 25); // Orange
    fill(234, 210, 147);
    ellipse(60, 180, 25, 25); // Light Brown
    fill(131, 114, 70);
    ellipse(100, 180, 25, 25); // Dark Brown
    fill(255);
    ellipse(20, 220, 25, 25); // White
    fill(175);
    ellipse(60, 220, 25, 25); // Light Gray
    fill(0);
    ellipse(100, 220, 25, 25); // Black
}

void selectColor() {
    stroke(0);
    //Check mouse click position and set currentColor accordingly
    if(mouseX >= 5 && mouseX <= 35 && mouseY >= 5 && mouseY <= 35) {
            currentColor = color(183, 24, 24); // Red
            rect(5, 5, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 5 && mouseY <= 35) {
            currentColor = color(255, 13, 13); // Light Red
            rect(45, 5, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 5 && mouseY <= 35) {
            currentColor = color(240, 41, 157); // Pink
            rect(85, 5, 30, 30);
    } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 45 && mouseY <= 75) {
            currentColor = color(236, 41, 240); // Light Purple
            rect(5, 45, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 45 && mouseY <= 75) {
            currentColor = color(169, 41, 240); // Purple
            rect(45, 45, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 45 && mouseY <= 75) {
            currentColor = color(116, 41, 240); // Dark Purple
            rect(85, 45, 30, 30);
    } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 85 && mouseY <= 115) {
            currentColor = color(24, 22, 240); // Blue
            rect(5, 85, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 85 && mouseY <= 115) {
            currentColor = color(22, 194, 240); // Light Blue
            rect(45, 85, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 85 && mouseY <= 115) {
            currentColor = color(22, 240, 187); // Cyan
            rect(85, 85, 30, 30);
    } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 125 && mouseY <= 155) {
            currentColor = color(51, 229, 52); // Green
            rect(5, 125, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 125 && mouseY <= 155) {
            currentColor = color(225, 245, 79); // Yellow Green
            rect(45, 125, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 125 && mouseY <= 155) {
            currentColor = color(255, 244, 31); // Yellow
            rect(85, 125, 30, 30);
    } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 165 && mouseY <= 195) {
            currentColor = color(255, 157, 52); // Orange
            rect(5, 165, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 165 && mouseY <= 195) {
            currentColor = color(234, 210, 147); // Light Brown
            rect(45, 165, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 165 && mouseY <= 195) {
            currentColor = color(131, 114, 70); // Dark Brown
            rect(85, 165, 30, 30);
    } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 205 && mouseY <= 235) {
            currentColor = color(255); // White
            rect(5, 205, 30, 30);
    } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 205 && mouseY <= 235) {
            currentColor = color(175); // Light Gray
            rect(45, 205, 30, 30);
    } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 205 && mouseY <= 235) {
            currentColor = color(0); // Black
            rect(85, 205, 30, 30);
    }
}
