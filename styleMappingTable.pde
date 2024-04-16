import java.util.HashMap;


class StyleMappingTable {
    public HashMap<String, Tool> getStyles(GlobalFeature globalFeature) {
        HashMap<String, Tool> style = new HashMap<>();

        if (globalFeature.getNumberOfColor() > 1) { // Corrected method call
            style.put("line", new LineTool1());
        } else {
            style.put("line", new LineTool2());
        }

        if (globalFeature.getNumberOfPoints() > 10) { // Corrected method call
            style.put("pattern", new PatternTool1());
        } else {
            style.put("pattern", new PatternTool2());
        }

        style.put("mask", new Torso1());
        return style;
    }
}
