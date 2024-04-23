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
            add(new float[]{coordinates[0], coordinates[1]);
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


class Torso3 extends Boundary {
    public Torso3() {
        super(new ArrayList<>() {{
            add(new float[]{602, 2});
            add(new float[]{600, 123});
            add(new float[]{817, 139});
            add(new float[]{846, 12});
            add(new float[]{986, 24});
            add(new float[]{987, 64});
            add(new float[]{891, 66});
            add(new float[]{866, 170});
            add(new float[]{664, 167});
            add(new float[]{750, 485});
            add(new float[]{789, 746});
            add(new float[]{182, 744});
            add(new float[]{291, 263});
            add(new float[]{176, 257});
            add(new float[]{65, 351});
            add(new float[]{68, 217});
            add(new float[]{93, 185});
            add(new float[]{116, 251});
            add(new float[]{152, 208});
            add(new float[]{231, 206});
            add(new float[]{344, 146});
            add(new float[]{363, 7});
            add(new float[]{602, 2});
        }});
    }
}



class Torso4 extends Boundary {
    public Torso4() {
        super(new ArrayList<>() {{
            add(new float[]{425, 228});
            add(new float[]{454, 379});
            add(new float[]{569, 345});
            add(new float[]{590, 445});
            add(new float[]{442, 538});
            add(new float[]{327, 191});
            add(new float[]{455, 192});
            add(new float[]{507, 2});
            add(new float[]{623, 2});
            add(new float[]{599, 189});
            add(new float[]{780, 185});
            add(new float[]{714, 750});
            add(new float[]{337, 750});
            add(new float[]{381, 367});
        }});
    }
}


class Feet1 extends Boundary {
    public Feet1() {
        super(new ArrayList<>() {{
                add(new float[]{439, 0});
                add(new float[]{360, 241});
                add(new float[]{487, 487});
                add(new float[]{472, 658});
                add(new float[]{563, 469});
                add(new float[]{441, 261});
                add(new float[]{543, 0});

                add(new float[]{765, 0});
                add(new float[]{690, 271});
                add(new float[]{782, 459});
                add(new float[]{795, 637});
                add(new float[]{861, 437});
                add(new float[]{750, 260});
                add(new float[]{861, 0});
        }});
    }
}

class Feet2 extends Boundary {
    public Feet2() {
        super(new ArrayList<>() {{
add(new float[]{384, 0});
add(new float[]{477, 259});
add(new float[]{386, 694});
add(new float[]{548, 698});
add(new float[]{583, 264});
add(new float[]{529, 0});

add(new float[]{637, 0});
add(new float[]{782, 692});
add(new float[]{940, 683});
add(new float[]{728, 0});
        }});
    }
}


class Feet3 extends Boundary {
    public Feet3() {
        super(new ArrayList<>() {{
          add(new float[]{531, 0});
add(new float[]{519, 359});
add(new float[]{343, 522});
add(new float[]{298, 480});
add(new float[]{337, 582});
add(new float[]{577, 357});
add(new float[]{609, 0});

add(new float[]{721, 0});
add(new float[]{730, 349});
add(new float[]{888, 557});
add(new float[]{943, 462});
add(new float[]{892, 486});
add(new float[]{786, 337});
add(new float[]{815, 0});
        }});
    }
}