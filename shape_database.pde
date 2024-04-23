class ShapeDatabase {
    ArrayList<Shape> shapes_1;
    ArrayList<Shape> shapes_3;
    PImage img_1;
    PImage img_2;
    PImage img_3;
    PImage img_4;
    Style style_2;
    Style style_4;

    public void display_img1(DisplayMode mode) {
        this.img_1 = loadImage("HUMAN_DRAW_1.png");
        if (mode == DisplayMode.WINDOW1) {
            image(this.img_1, 1001, 1, 199, 149);
        } else if (mode == DisplayMode.FINAL_DISPLAY1) {
            image(this.img_1, 400, 1, 250, 187);
        }        
    }
    
    public void display_img2(DisplayMode mode) {
        this.img_2 = loadImage("COMPUTER_DRAW_2.png");
        if (mode == DisplayMode.WINDOW2) {
            image(this.img_2, 1001, 151, 199, 149);
        } else if (mode == DisplayMode.FINAL_DISPLAY2) {
            image(this.img_2, 400, 187, 250, 187);
        }        
    }

    public void display_img3(DisplayMode mode) {
        this.img_3 = loadImage("HUMAN_DRAW_3.png");
        if (mode == DisplayMode.WINDOW3) {
            image(this.img_3, 1001, 301, 199, 149);
        } else if (mode == DisplayMode.FINAL_DISPLAY3) {
            image(this.img_3, 400, 375, 250, 187);
        }        
    }

    public void display_img4(DisplayMode mode) {
        this.img_4 = loadImage("COMPUTER_DRAW_4.png");
        if (mode == DisplayMode.FINAL_DISPLAY4) {
            image(this.img_4, 400, 563, 250, 187);
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

    public void deletePreviousShape(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            if (this.shapes_1.size() == 0) {
                return;
            }

            this.shapes_1.remove(this.shapes_1.size() - 1);
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            if (this.shapes_3.size() == 0) {
                return;
            }
            this.shapes_3.remove(this.shapes_3.size() - 1);
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
            // for (Shape shape : this.shapes_1) {
            //     shape.display(DisplayMode.WINDOW1);
            // }

            display_img1(DisplayMode.WINDOW1);

        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            // for (Shape shape : this.shapes_1) {
            //     shape.display(DisplayMode.WINDOW1);
            // }

            display_img1(DisplayMode.WINDOW1);
            display_img2(DisplayMode.WINDOW2);

        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            // for (Shape shape : this.shapes_1) {
            //     shape.display(DisplayMode.WINDOW1);
            // }

            display_img1(DisplayMode.WINDOW1);

            display_img2(DisplayMode.WINDOW2);

            // for (Shape shape : this.shapes_3) {
            //     shape.display(DisplayMode.WINDOW3);
            // }  

            display_img3(DisplayMode.WINDOW3);        

        } else if (stage == GlobalStage.FINAL_STAGE) {
            display_img1(DisplayMode.FINAL_DISPLAY1);
            display_img2(DisplayMode.FINAL_DISPLAY2);
            display_img3(DisplayMode.FINAL_DISPLAY3);
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
