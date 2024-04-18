class Style {
    Boundary boundary;
    PatternTool insidePatternTool;
    PatternTool outsidePatternTool;
    LineTool lineTool;

    public Style(Boundary boundary, PatternTool insidePatternTool, PatternTool outsidePatternTool, LineTool lineTool) {
        this.boundary = boundary;
        this.insidePatternTool = insidePatternTool;
        this.outsidePatternTool = outsidePatternTool;
        this.lineTool = lineTool;
    }

    public void display() {
        insidePatternTool.display();
        outsidePatternTool.display();
        lineTool.display();
    }

    // public void display(DisplayMode displayMode) {
    //     insidePatternTool.display(displayMode);
    //     outsidePatternTool.display(displayMode);
    //     lineTool.display(displayMode);
    // }

}