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
        outsidePatternTool.display();
        insidePatternTool.display();
        funTool.display();
        lineTool.display();
        
    }

}