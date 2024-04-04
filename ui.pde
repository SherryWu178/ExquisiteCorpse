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



void drawColorSelections() {
  stroke(0);
  strokeWeight(2);
  
  // Draw color ellipses
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