import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.HashSet;

class PretransformParametersExtractor {
    public PretransformParametersExtractor() {}

    public PretransformParameters extract(ShapeDatabase shapeDatabase, GlobalStage globalStage) {

        ArrayList<Shape> shapes = shapeDatabase.getShapes(globalStage);
        
        float meanX = 0, meanY = 0;
        float maxX = Float.MIN_VALUE, maxY = Float.MIN_VALUE;
        float minX = Float.MAX_VALUE, minY = Float.MAX_VALUE;
        float sumX = 0, sumY = 0;
        List<float[]> positionOfPoints = new ArrayList<>();
        Set<float[]> uniqueColors = new HashSet<>();

        println("Number of shapes: ", shapes.size());
        for (Shape shape : shapes) {
            float[] position = shape.getPosition();
            int shapeColor = shape.getColor();
            float b = blue(shapeColor);
            float g = green(shapeColor);
            float r = red(shapeColor);

            // Check if a color with the same components exists in the set
            boolean colorExists = false;
            for (float[] uniqueColor : uniqueColors) {
                if (uniqueColor[0] == r && uniqueColor[1] == g && uniqueColor[2] == b) {
                    colorExists = true;
                    break;
                }
            }

            // If the color doesn't exist, add it to the set
            if (!colorExists) {
                uniqueColors.add(new float[]{r, g, b});
            }

            positionOfPoints.add(position);
            sumX += position[0];
            sumY += position[1];
            maxX = Math.max(maxX, position[0]);
            maxY = Math.max(maxY, position[1]);
            minX = Math.min(minX, position[0]);
            minY = Math.min(minY, position[1]);
        }

        meanX = sumX / positionOfPoints.size();
        meanY = sumY / positionOfPoints.size();

        float[] topLeft = {minX, minY};
        float[] bottomRight = {maxX, maxY};
        float[] centerOfMass = {meanX, meanY};

        // Create HatchDensity instance
        HatchDensity hatchDensity = new HatchDensity(topLeft, bottomRight, centerOfMass);
        int numberOfUniqueColors = uniqueColors.size();
        PretransformParameters pretransformParameters = new PretransformParameters(hatchDensity, numberOfUniqueColors, positionOfPoints);

        return pretransformParameters;
     }
};


class PretransformParameters {
    private HatchDensity densityOfHatch;
    private int numberOfColor;
    private List<float[]> positionOfPoints;

    public PretransformParameters(HatchDensity densityOfHatch, int numberOfColor, List<float[]> positionOfPoints) {
        this.densityOfHatch = densityOfHatch;
        this.numberOfColor = numberOfColor;
        this.positionOfPoints = positionOfPoints;
    }

    // Constructor, getters, and setters
    public HatchDensity getDensityOfHatch() {
        return densityOfHatch;
    }

    public void setDensityOfHatch(HatchDensity densityOfHatch) {
        this.densityOfHatch = densityOfHatch;
    }

    public int getNumberOfColor() {
        return numberOfColor;
    }

    public void setNumberOfColor(int numberOfColor) {
        this.numberOfColor = numberOfColor;
    }

    public List<float[]> getPositionOfPoints() {
        return positionOfPoints;
    }

    public void setPositionOfPoints(List<float[]> positionOfPoints) {
        this.positionOfPoints = positionOfPoints;
    }

    public int getNumberOfPoints() {
        return positionOfPoints.size();
    }

}

class HatchDensity {
    private float[] topLeft;
    private float[] bottomRight;
    private float[] centerOfMass;

    public HatchDensity(float[] topLeft, float[] bottomRight, float[] centerOfMass) {
        this.topLeft = topLeft;
        this.bottomRight = bottomRight;
        this.centerOfMass = centerOfMass;
    }

    // Constructor, getters, and setters
    public float[] getTopLeft() {
        return topLeft;
    }

    public void setTopLeft(float[] topLeft) {
        this.topLeft = topLeft;
    }

    public float[] getBottomRight() {
        return bottomRight;
    }

    public void setBottomRight(float[] bottomRight) {
        this.bottomRight = bottomRight;
    }

    public float[] getCenterOfMass() {
        return centerOfMass;
    }

    public void setCenterOfMass(float[] centerOfMass) {
        this.centerOfMass = centerOfMass;
    }
}
