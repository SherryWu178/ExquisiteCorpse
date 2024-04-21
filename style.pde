class Style {
    Boundary boundary;
    PatternTool insidePatternTool;
    PatternTool outsidePatternTool;
    LineTool lineTool;
    FunTool funTool;

    public Style(Boundary boundary, PatternTool insidePatternTool, PatternTool outsidePatternTool, LineTool lineTool, FunTool funTool) {
        this.boundary = boundary;
        this.insidePatternTool = insidePatternTool;
        this.outsidePatternTool = outsidePatternTool;
        this.lineTool = lineTool;
        this.funTool = funTool;
    }

    public void display() {
        insidePatternTool.display();
        outsidePatternTool.display();
        lineTool.display();
        funTool.display();
    }

    // public void display(DisplayMode displayMode) {
    //     insidePatternTool.display(displayMode);
    //     outsidePatternTool.display(displayMode);
    //     lineTool.display(displayMode);
    // }

}