import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class CoordinateTransformer {

    public HashMap<DisplayMode, float[]> coordinatesMap = new HashMap<>() {{
        put(DisplayMode.MAIN, new float[]{0, 0, 1000, 750});
        put(DisplayMode.WINDOW1, new float[]{1000, 0, 1200, 150});
        put(DisplayMode.WINDOW2, new float[]{1000, 150, 1200, 300});
        put(DisplayMode.WINDOW3, new float[]{1000, 300, 1200, 450});
        put(DisplayMode.WINDOW4, new float[]{1000, 450, 1200, 600});
        put(DisplayMode.FINAL_DISPLAY1, new float[]{400, 0, 600, 150});
        put(DisplayMode.FINAL_DISPLAY2, new float[]{400, 150, 600, 300});
        put(DisplayMode.FINAL_DISPLAY3, new float[]{400, 300, 600, 450});
        put(DisplayMode.FINAL_DISPLAY4, new float[]{400, 450, 600, 600});
    }};

    // Function to transform a point from one rectangle coordinate system to another
    public float[] transformPoint(DisplayMode displayMode, float[] pointCoords) {
        float[] originalCoords = coordinatesMap.get(DisplayMode.MAIN);
        float[] newFrameCoords = coordinatesMap.get(displayMode);

        float x1 = originalCoords[0];
        float y1 = originalCoords[1];
        float x2 = originalCoords[2];
        float y2 = originalCoords[3];
        
        float newX1 = newFrameCoords[0];
        float newY1 = newFrameCoords[1];
        float newX2 = newFrameCoords[2];
        float newY2 = newFrameCoords[3];
        
        // Calculate scaling factors
        double xScale = (double)(newX2 - newX1) / (x2 - x1);
        double yScale = (double)(newY2 - newY1) / (y2 - y1);
        
        // Apply scaling and translation
        float x = (float) (xScale * (pointCoords[0] - x1) + newX1); // Transformed x-coordinate
        float y = (float) (yScale * (pointCoords[1] - y1) + newY1); // Transformed y-coordinate
        
        // Update the pointCoords array with transformed coordinates
        pointCoords[0] = x;
        pointCoords[1] = y;
        
        // Return the transformed coordinates
        return pointCoords;
    }

    // Function to transform a list of points from one rectangle coordinate system to another
    public ArrayList<float[]> transformArray(DisplayMode displayMode, List<float[]> points) {
        ArrayList<float[]> transformedPoints = new ArrayList<>();
        
        for (float[] point : points) {
            float[] transformedPoint = transformPoint(displayMode, point);
            transformedPoints.add(transformedPoint);
        }
        
        return transformedPoints;
    }

    public void transformSohyunLine(List<float[]> points, DisplayMode displayMode){
        ArrayList<float[]> transformedPoints = transformArray(displayMode, points);
        for (int i = 0; i < transformedPoints.size() - 1; i++) {
            float[] point1 = transformedPoints.get(i);
            float[] point2 = transformedPoints.get(i + 1);
            line(point1[0], point1[1], point2[0], point2[1]);
            print(second()); 
            print("\n I am displaying segment\n");

        }
    }

    public void transformRectangle(float x, float y, float length, float width, DisplayMode displayMode){
        float[] point1 = {x, y};
        float[] point2 = {x + length, y};
        float[] point3 = {x + length, y + width};
        float[] point4 = {x, y + width};
        
        ArrayList<float[]> points = new ArrayList<>();
        points.add(point1);
        points.add(point2);
        points.add(point3);
        points.add(point4);
        
        ArrayList<float[]> transformedPoints = transformArray(displayMode, points);
        
        float[] transformedPoint1 = transformedPoints.get(0);
        float[] transformedPoint2 = transformedPoints.get(1);
        float[] transformedPoint3 = transformedPoints.get(2);
        float[] transformedPoint4 = transformedPoints.get(3);

        float newLength = transformedPoint2[0] - transformedPoint1[0];
        float newWidth = transformedPoint3[1] - transformedPoint2[1];
        rect(transformedPoint1[0], transformedPoint1[1], newLength, newWidth);
    }

    public void transformCircle(float x, float y, float radius, DisplayMode displayMode){
        float[] point = {x, y};
        float[] transformedPoint = transformPoint(displayMode, point);
        float newX = transformedPoint[0];
        float newY = transformedPoint[1];

        float newLength = (coordinatesMap.get(displayMode)[2] - coordinatesMap.get(displayMode)[0]);
        float oldLength = (coordinatesMap.get(DisplayMode.MAIN)[2] - coordinatesMap.get(DisplayMode.MAIN)[0]);
        float scaleRatio =  newLength / oldLength;
        float newRadis = radius * scaleRatio;
        circle(newX, newY, newRadis);

    }

}
