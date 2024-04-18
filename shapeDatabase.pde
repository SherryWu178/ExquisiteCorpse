class ShapeDatabase {
    ArrayList<Shape> shapes_1;
    ArrayList<Shape> shapes_2;
    ArrayList<Shape> shapes_3;
    ArrayList<Shape> shapes_4;
    PGraphics pg2;
    PGraphics pg4;

    public ShapeDatabase() {
        this.shapes_1 = new ArrayList<Shape>();
        this.shapes_2 = new ArrayList<Shape>();
        this.shapes_3 = new ArrayList<Shape>();
        this.shapes_4 = new ArrayList<Shape>();
    }

    public ArrayList<Shape> getShapes(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            return this.shapes_1;
        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            return this.shapes_2;
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            return this.shapes_3;
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            return this.shapes_4;
        }
        return null;
    }

    public void addShape(Shape shape, GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            this.shapes_1.add(shape);
        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            this.shapes_2.add(shape);
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            this.shapes_3.add(shape);
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            this.shapes_4.add(shape);
        }
    }

    public void displayShapes(GlobalStage stage) {
        if (stage == GlobalStage.HUMAN_DRAW_1) {
            for (Shape shape : this.shapes_1) {
                shape.display();
            }
        } else if (stage == GlobalStage.COMPUTER_DRAW_2) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }

            computer_draw();

            // for (Shape shape : this.shapes_2) {
            //     shape.display();
            // }
        } else if (stage == GlobalStage.HUMAN_DRAW_3) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }

            for (Shape shape : this.shapes_2) {
                shape.display(DisplayMode.WINDOW2);
            }

            for (Shape shape : this.shapes_3) {
                shape.display();
            }
        } else if (stage == GlobalStage.COMPUTER_DRAW_4) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.WINDOW1);
            }

            // for (Shape shape : this.shapes_2) {
            //     shape.display(DisplayMode.WINDOW2);
            // }

            for (Shape shape : this.shapes_3) {
                shape.display(DisplayMode.WINDOW3);
            }

            computer_draw();
            
            // for (Shape shape : this.shapes_4) {
            //     shape.display();
            // }
            
        } else if (stage == GlobalStage.FINAL_STAGE) {
            for (Shape shape : this.shapes_1) {
                shape.display(DisplayMode.FINAL_DISPLAY);
            }

            for (Shape shape : this.shapes_2) {
                shape.display(DisplayMode.FINAL_DISPLAY);
            }

            for (Shape shape : this.shapes_3) {
                shape.display(DisplayMode.FINAL_DISPLAY);
            }
            
            for (Shape shape : this.shapes_4) {
                shape.display(DisplayMode.FINAL_DISPLAY);
            }
        }
    }
}
