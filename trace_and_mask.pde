import java.util.ArrayList;
import java.util.List;


abstract class Boundary implements Tool {
    private List<float[]> coordinatesList = new ArrayList<>();

    public Boundary(List<float[]> coordinatesList) {
        this.coordinatesList = coordinatesList;
    }

    public List<float[]> getCoordinatesList() {
        return coordinatesList;
    }

    boolean contains(int[] p) {
        float[] newp = new float[]{p[0], p[1]};
        return contains(newp);
    }


    boolean contains(float[] p) {
        float[] rayEnd = new float[]{width * 10, height * 10}; 
        int intersections = 0;
        
        for (int i = 0; i < this.coordinatesList.size(); i++) {
            float[] a = this.coordinatesList.get(i);
            float[] b = this.coordinatesList.get((i + 1) % this.coordinatesList.size());
            if (intersect(a, b, p, rayEnd)) {
                intersections++;
            }
        }
        return intersections % 2 == 1;
    }

    boolean intersect(float[] a, float[] b, float[] c, float[] d) {
        float tNom = (a[0] - c[0]) * (c[1] - d[1]) - (a[1] - c[1]) * (c[0] - d[0]);
        float tDenom = (a[0] - b[0]) * (c[1] - d[1]) - (a[1] - b[1]) * (c[0] - d[0]);
        float uNom = (a[0] - c[0]) * (a[1] - b[1]) - (a[1] - c[1]) * (a[0] - b[0]);
        float uDenom = (a[0] - b[0]) * (c[1] - d[1]) - (a[1] - b[1]) * (c[0] - d[0]);
        return Math.abs(tNom) < Math.abs(tDenom) && sign(tNom) == sign(tDenom) && Math.abs(uNom) < Math.abs(uDenom) && sign(uNom) == sign(uDenom);
    }

    int sign(float value) {
        return value < 0 ? -1 : value > 0 ? 1 : 0;
    }

    public void display(DisplayMode displayMode) {
        List<float[]> coordinatesList = this.getCoordinatesList();
        // display the boundary
        List<float[]> resizedCoordinatesList = new CoordinateTransformer().transformArray(displayMode, coordinatesList);
        beginShape();
        for (float[] coordinates : resizedCoordinatesList) {
            vertex(coordinates[0], coordinates[1]);
        }
        endShape(CLOSE);
    }
}

class Torso1 extends Boundary {
    public Torso1() {
        super(new ArrayList<>() {{
            add(new float[]{487, 0});
            add(new float[]{487, 750});
            add(new float[]{730, 750});
            add(new float[]{730, 0});
        }});
    }
}

class Torso2 extends Boundary {
    public Torso2() {
        super(new ArrayList<>() {{
            add(new float[]{487, 0});
            add(new float[]{459, 162});
            add(new float[]{192, 336});
            add(new float[]{258, 428});
            add(new float[]{364, 393});
            add(new float[]{371, 750});
            add(new float[]{601, 744});//reduced the #of points
            add(new float[]{814, 410});
            add(new float[]{767, 410});
            add(new float[]{568, 232});
            add(new float[]{558, 0});
        }});
    }
}

        //super(new ArrayList<>() {{
        //    add(new float[]{487, 0});
        //    add(new float[]{459, 162});
        //    add(new float[]{192, 336});
        //    add(new float[]{258, 428});
        //    add(new float[]{364, 393});
        //    add(new float[]{371, 750});
        //    add(new float[]{601, 744});
        //    add(new float[]{625, 376});
        //    add(new float[]{722, 503});
        //    add(new float[]{740, 456});
        //    add(new float[]{814, 410});
        //    add(new float[]{814, 410});
        //    add(new float[]{767, 410});
        //    add(new float[]{568, 232});
        //    add(new float[]{558, 0});
