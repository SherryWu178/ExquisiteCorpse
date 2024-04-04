void toolBar() {
    //Draw background of toolbar
    fill(150);

	// color selection
 
	drawColorSelections();

	drawThichnessSelection();
    
	drawShapeSelections();
}

void drawThichnessSelection() {	    
    fill(150);
    strokeWeight(1);
    rect( - 1, 249, 125, 251);

    //Drawline thickness selections
	fill(0);
    ellipse(60, 295, 5, 5);
    ellipse(60, 325, 10, 10);
    ellipse(60, 360, 15, 15);
    ellipse(60, 400, 25, 25);
    ellipse(60, 450, 35, 35);
}

void drawShapeSelections() {

	fill(150);
    strokeWeight(1);
    rect( - 1, 499, 125, 251);


	stroke(0);
	strokeWeight(2);
	
	//Draw shape ellipses
	fill(255);
	ellipse(60, 545, 35, 35); // Circle
	fill(255);
	rect(45, 585, 30, 30); // Square

	beginShape();
	vertex(45, 625); // first point
	bezierVertex(25, 25, 100, 50, 50, 100);
	bezierVertex(20, 130, 75, 140, 120, 120);
	endShape();
	// fill(255);
	// triangle(60, 640, 45, 665, 75, 665); // Triangle
}

void drawColorSelections() {
	stroke(0);
	strokeWeight(1);
    rect( - 1, -1, 125, 250);

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
  // Check mouse click position and set currentColor accordingly
  if (mouseX >= 5 && mouseX <= 35 && mouseY >= 5 && mouseY <= 35) {
    currentColor = color(183, 24, 24); // Red
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 5 && mouseY <= 35) {
    currentColor = color(255, 13, 13); // Light Red
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 5 && mouseY <= 35) {
    currentColor = color(240, 41, 157); // Pink
  } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 45 && mouseY <= 75) {
    currentColor = color(236, 41, 240); // Light Purple
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 45 && mouseY <= 75) {
    currentColor = color(169, 41, 240); // Purple
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 45 && mouseY <= 75) {
    currentColor = color(116, 41, 240); // Dark Purple
  } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 85 && mouseY <= 115) {
    currentColor = color(24, 22, 240); // Blue
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 85 && mouseY <= 115) {
    currentColor = color(22, 194, 240); // Light Blue
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 85 && mouseY <= 115) {
    currentColor = color(22, 240, 187); // Cyan
  } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 125 && mouseY <= 155) {
    currentColor = color(51, 229, 52); // Green
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 125 && mouseY <= 155) {
    currentColor = color(225, 245, 79); // Yellow Green
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 125 && mouseY <= 155) {
    currentColor = color(255, 244, 31); // Yellow
  } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 165 && mouseY <= 195) {
    currentColor = color(255, 157, 52); // Orange
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 165 && mouseY <= 195) {
    currentColor = color(234, 210, 147); // Light Brown
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 165 && mouseY <= 195) {
    currentColor = color(131, 114, 70); // Dark Brown
  } else if (mouseX >= 5 && mouseX <= 35 && mouseY >= 205 && mouseY <= 235) {
    currentColor = color(255); // White
  } else if (mouseX >= 45 && mouseX <= 75 && mouseY >= 205 && mouseY <= 235) {
    currentColor = color(175); // Light Gray
  } else if (mouseX >= 85 && mouseX <= 115 && mouseY >= 205 && mouseY <= 235) {
    currentColor = color(0); // Black
  }
}
