// This method draws a coil consisting of a number of circles between two
// points. It is supposed to be an illustration of a spring in illustrations of
// physical systems. Input: startX, startY, endX, end Y, numOfCircles, r. startX,
// startY, endX and endY is the coordinates of the two points that is connected
// with the coil. numOfCircles is the number of circles that the coil cosists of.
// r is the radius of the circles.
// If better performance is wished, try to numerator when defining stepSize a
// higher number.
class Coil {
    float startX;
    float startY;
    float endX;
    float endY;
    float numOfCircles;
    float r;

    public Coil(float startX, float startY, float endX, float endY, float numOfCircles, float r) {
        this.startX = startX;
        this.startY = startY;
        this.endX = endX;
        this.endY = endY;
        this.numOfCircles = numOfCircles;
        this.r = r;

    }

        public void display(DisplayMode mode) {
        float radius = r;
        PVector start = new PVector(startX, startY);
        PVector end = new PVector(endX, endY);
        float distance = (start.dist(end) - 2 * radius)
            * (1
                + 0.505
                    / (numOfCircles
                        - 0.476)); // The factor "(1 + 0.505/(numOfCircles-0.476))"
                                // is a hyperbola that makes the coil start and
                                // end at the right places.
        float numberOfCircles = numOfCircles;
        float stepSize = 2 / numOfCircles;
        float t = 0;

        float angle =
            rotateWithFixPointsAndGetAng(end.x, end.y, start.x, start.y, radius);

        for (t = 0; t < numberOfCircles * 2 * PI - PI; t += stepSize) {
            line(cos(t + PI) * radius
                    + map(t, 0, numberOfCircles * 2 * PI, 0, distance),
                sin(t) * radius,
                cos(t + PI + stepSize) * radius
                    + map(t, 0, numberOfCircles * 2 * PI, 0, distance),
                sin(t + stepSize) * radius);
        }

        // Rotate and translate back, so furthur coordinates aren't affected by
        // this.
        rotate(-angle);
        translate(-radius * cos(angle), -radius * sin(angle));
        translate(-end.x, -end.y);
    }

    public void display() {
        float radius = r;
        PVector start = new PVector(startX, startY);
        PVector end = new PVector(endX, endY);
        float distance = (start.dist(end) - 2 * radius)
            * (1
                + 0.505
                    / (numOfCircles
                        - 0.476)); // The factor "(1 + 0.505/(numOfCircles-0.476))"
                                // is a hyperbola that makes the coil start and
                                // end at the right places.
        float numberOfCircles = numOfCircles;
        float stepSize = 2 / numOfCircles;
        float t = 0;

        float angle =
            rotateWithFixPointsAndGetAng(end.x, end.y, start.x, start.y, radius);

        for (t = 0; t < numberOfCircles * 2 * PI - PI; t += stepSize) {
            line(cos(t + PI) * radius
                    + map(t, 0, numberOfCircles * 2 * PI, 0, distance),
                sin(t) * radius,
                cos(t + PI + stepSize) * radius
                    + map(t, 0, numberOfCircles * 2 * PI, 0, distance),
                sin(t + stepSize) * radius);
        }

        // Rotate and translate back, so furthur coordinates aren't affected by
        // this.
        rotate(-angle);
        translate(-radius * cos(angle), -radius * sin(angle));
        translate(-end.x, -end.y);
    }

    //**This is a special case of rotateWithcFixPoints**, that is made specificly
    //for Spring_illustration.

    // This method works like a translate and rotate.
    // It takes the coordinates of two points (a center point and a lead point), and
    // rotates an object around the center object according to the coordinates of the
    // lead point. This way, the translated object will stay on the line that goes
    // through both the center point and the lead point.
    void rotateWithFixPoints(float centerX, float centerY, float leadPointX,
        float leadPointY, float radius) {
        float ang = 0;
        PVector center = new PVector(centerX, centerY);
        PVector leadPoint = new PVector(leadPointX, leadPointY);

        translate(center.x, center.y);
        if (leadPoint.y - center.y < 0) {
            ang =
                asin((leadPoint.x - center.x)
                    / sqrt(sq(leadPoint.x - center.x) + sq(leadPoint.y - center.y)))
                - PI;
        } else {
            ang = -asin((leadPoint.x - center.x)
                / sqrt(sq(leadPoint.x - center.x) + sq(leadPoint.y - center.y)));
        }
        translate(radius * cos(ang + PI / 2), radius * sin(ang + PI / 2));
        rotate(ang + PI / 2);
    }

    float rotateWithFixPointsAndGetAng(float centerX, float centerY,
        float leadPointX, float leadPointY, float radius) {
        float ang = 0;
        PVector center = new PVector(centerX, centerY);
        PVector leadPoint = new PVector(leadPointX, leadPointY);

        translate(center.x, center.y);
        if (leadPoint.y - center.y < 0) {
            ang =
                asin((leadPoint.x - center.x)
                    / sqrt(sq(leadPoint.x - center.x) + sq(leadPoint.y - center.y)))
                - PI;
        } else {
            ang = -asin((leadPoint.x - center.x)
                / sqrt(sq(leadPoint.x - center.x) + sq(leadPoint.y - center.y)));
        }
        translate(radius * cos(ang + PI / 2), radius * sin(ang + PI / 2));
        rotate(ang + PI / 2);
        return ang + PI / 2;
    }
    
}
