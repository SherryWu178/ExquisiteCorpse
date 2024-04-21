class ShapeDatabase {
    ArrayList<Shape> shapes_1;
    ArrayList<Shape> shapes_3;
    PImage img_2;
    PImage img_4;

    public void display_img2(DisplayMode mode) {
        this.img_2 = loadImage("COMPUTER_DRAW_2.png");
        if (mode == DisplayMode.WINDOW2) {
            image(this.img_2, 1001, 151, 199, 149);
        } else if (mode == DisplayMode.FINAL_DISPLAY2) {
            image(this.img_2, 400, 150, 200, 150);
        }        
    }


    public void display_img4(DisplayMode mode) {
        this.img_4 = loadImage("COMPUTER_DRAW_4.png");
        if (mode == DisplayMode.FINAL_DISPLAY4) {
            image(this.img_4, 400, 450, 200, 150);
        }
    }

    public ShapeDatabase() {
        this.shapes_1 = new ArrayList<Shape>();
        this.shapes_3 = new ArrayList<Shape>();
    }

    public ArrayList<Shape> getShapes(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            return this.shapes_1;
        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            throw new RuntimeException("Cannot get shapes for stage 2");
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            return this.shapes_3;
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            throw new RuntimeException("Cannot get shapes for stage 4");
        } else {
            throw new RuntimeException("Cannot get shapes for final stage");
        }
    }

    public void addShape(Shape shape, GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            println("Adding shape to stage 1");
            this.shapes_1.add(shape);
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            println("Adding shape to stage 3");
            this.shapes_3.add(shape);
        }
    }

    public void addStyle(Style style, GlobalStage stage) {
        if (stage == GlobalStage.COMPUTER_DRAW_2) {
            println("Adding style to stage 2");
            this.style_2 = style;
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            println("Adding style to stage 4");
            this.style_4 = style;
        }
    }

    public void displaySidePanel(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            return;

        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }

            display_img2(DisplayMode.WINDOW2);

        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }

            display_img2(DisplayMode.WINDOW2);

            for (Shape shape : this.shapes_3) {
                shape.display(DisplayMode.WINDOW3);
            }          

        } else if (stage == GlobalStage.FINAL_STAGE) {
            display_img2(DisplayMode.FINAL_DISPLAY2);
            display_img4(DisplayMode.FINAL_DISPLAY4);
        }
    }

    public void displayMainCanvas(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            for (Shape shape : this.shapes_1) {
                shape.display();
            }
        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            style_2.display();

        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            for (Shape shape : this.shapes_3) {
                shape.display();
            }
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            style_4.display();
            
        } else if (stage == GlobalStage.FINAL_STAGE) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.FINAL_DISPLAY1);
            }

            // style_2.display(DisplayMode.FINAL_DISPLAY);

            for (Shape shape : this.shapes_3) {
                shape.display(DisplayMode.FINAL_DISPLAY3);
            }
            
            // style_4.display(DisplayMode.FINAL_DISPLAY);
        }
    }
}
