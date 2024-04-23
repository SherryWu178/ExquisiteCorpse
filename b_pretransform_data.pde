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
        List<Float> polygonLengths = new ArrayList<>();

        for (Shape shape : shapes) {
            float[] position = shape.getPosition();
            float polygonLength = shape.getLength();
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

            // Add the length of the polygon to the array
            polygonLengths.add(polygonLength);
        }

        meanX = sumX / positionOfPoints.size();
        meanY = sumY / positionOfPoints.size();

        float[] topLeft = {minX, minY};
        float[] bottomRight = {maxX, maxY};
        float[] centerOfMass = {meanX, meanY};
        
        // Calculate curvatures
        List<float[]> positionOfPointsList = new ArrayList<>(positionOfPoints);
        float[] curvatures = calculateCurvatures((ArrayList<float[]>) positionOfPointsList);
        
        float minCurvature = Float.MAX_VALUE;
        float maxCurvature = Float.MIN_VALUE;
        for (float curvature : curvatures) {
            if (curvature < minCurvature) {
                minCurvature = curvature;
            }
            if (curvature > maxCurvature) {
                maxCurvature = curvature;
            }
        }

        // Calculate shape lengths
        float minL = polygonLengths.get(0);
        float maxL = polygonLengths.get(polygonLengths.size() - 1); // Retrieve last element

        // Iterate through the list to find min and max
        for (int i = 1; i < polygonLengths.size(); i++) {
            float length = polygonLengths.get(i);
            if (length < minL) {
                minL = length;
            }
            if (length > maxL) {
                maxL = length;
            }
        }
        float[] mLengths = {minL, maxL};

        // Calculate standard deviation for x and y coordinates
        float xStdDev = calculateStdDev((ArrayList<float[]>) positionOfPointsList, 0); // 0 represents x coordinate
        float yStdDev = calculateStdDev((ArrayList<float[]>) positionOfPointsList, 1); // 1 represents y coordinate
        float[] stdDev = {xStdDev, yStdDev};

        // Create HatchDensity instance
        HatchDensity hatchDensity = new HatchDensity(topLeft, bottomRight, centerOfMass, stdDev);
        int numberOfUniqueColors = uniqueColors.size();
        float[] mCurvatures = {minCurvature, maxCurvature};
        PretransformParameters pretransformParameters = new PretransformParameters(hatchDensity, numberOfUniqueColors, positionOfPoints, mCurvatures, mLengths);
        

        return pretransformParameters;
     }

    //FUNCTION FOR CALCULATING CURVATURES
    public float[] calculateCurvatures(ArrayList<float[]> points) {
        float[] curvatures = new float[points.size()];
        for (int i = 0; i < points.size(); i++) {
            float[] point1 = points.get((i - 1 + points.size()) % points.size());
            float[] point2 = points.get(i);
            float[] point3 = points.get((i + 1) % points.size());
            
            float curvature = calculateCurvature(point1, point2, point3);
            curvatures[i] = curvature;
        }
        return curvatures;
    }
    
    public float calculateCurvature(float[] point1, float[] point2, float[] point3) {
        // Calculate radius
        float radius = calculateRadius(point1, point2, point3);
        // Calculate curvature
        return radius;  //1.0f / radius;
    }
    
    public float calculateRadius(float[] point1, float[] point2, float[] point3) {
        // Calculate distances between points
        float dist12 = distance(point1, point2);
        float dist23 = distance(point2, point3);
        float dist31 = distance(point3, point1);
        
        // Calculate semiperimeter
        float s = (dist12 + dist23 + dist31) / 2.0f;
        
        // Calculate area of the triangle using Heron's formula
        float area = (float)Math.sqrt(s * (s - dist12) * (s - dist23) * (s - dist31));
        
        // Calculate radius of curvature
        return (dist12 * dist23 * dist31) / (4 * area);
    }
    
    public float distance(float[] point1, float[] point2) {
        float deltaX = point2[0] - point1[0];
        float deltaY = point2[1] - point1[1];
        return (float)Math.sqrt(deltaX * deltaX + deltaY * deltaY);
    }

    //FUNCTION FOR STANDARD DEVIATION
    public float calculateStdDev(ArrayList<float[]> points, int coordinateIndex) {
        int n = points.size();
        // Calculate mean
        float sum = 0;
        for (float[] point : points) {
            sum += point[coordinateIndex];
        }
        float mean = sum / n;

        // Calculate sum of squared differences
        float sumOfSquaredDiffs = 0;
        for (float[] point : points) {
            float diff = point[coordinateIndex] - mean;
            sumOfSquaredDiffs += diff * diff;
        }

        if (n < 1) {
           return 0; //insurance
        }
        // Calculate standard deviation
        return (float) Math.sqrt(sumOfSquaredDiffs / n );
    }
}


class PretransformParameters {
    private HatchDensity densityOfHatch;
    private int numberOfColor;
    private List<float[]> positionOfPoints;
    private float[] curvatures;
    private float[] shapeLengths;

    public PretransformParameters(HatchDensity densityOfHatch, int numberOfColor, 
                                List<float[]> positionOfPoints, float[] curvatures, 
                                float[] shapeLengths) {
        this.densityOfHatch = densityOfHatch;
        this.numberOfColor = numberOfColor;
        this.positionOfPoints = positionOfPoints;
        this.curvatures = curvatures;
        this.shapeLengths = shapeLengths;
    }

    // Constructor, getters, and setters
    public HatchDensity getDensityOfHatch() {
        return densityOfHatch;
    }

    // public void setDensityOfHatch(HatchDensity densityOfHatch) {
    //     this.densityOfHatch = densityOfHatch;
    // }

    public int getNumberOfColor() {
        return numberOfColor;
    }

    // public void setNumberOfColor(int numberOfColor) {
    //     this.numberOfColor = numberOfColor;
    // }

    public List<float[]> getPositionOfPoints() {
        return positionOfPoints;
    }

    // public void setPositionOfPoints(List<float[]> positionOfPoints) {
    //     this.positionOfPoints = positionOfPoints;
    // }

    public int getNumberOfPoints() {
        return positionOfPoints.size();
    }

    public float[] getCurvatures() {
        return curvatures;
    }
    
    public float[] getShapeLengths() {
        return shapeLengths;
    }
}

class HatchDensity {
    private float[] topLeft;
    private float[] bottomRight;
    private float[] centerOfMass;
    private float[] stdDev;

    public HatchDensity(float[] topLeft, float[] bottomRight, 
                        float[] centerOfMass, float[] stdDev) {
        this.topLeft = topLeft;
        this.bottomRight = bottomRight;
        this.centerOfMass = centerOfMass;
        this.stdDev = stdDev;
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

    public float[] getStdDev() {
        return stdDev;
    }
}

