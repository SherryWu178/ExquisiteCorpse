import java.util.ArrayList;
import java.util.List;


abstract class Boundary implements Tool {
    public final int neck1 = 507;
    public final int neck2 = 623;
    public final int torso1 = 337;
    public final int torso2 = 714;
    public final int leg1 = 439;
    public final int leg2 = 539;
    public final int leg3 = 765;
    public final int leg4 = 861;
    

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
            add(new float[]{507, 0});
            add(new float[]{507, 150});
            add(new float[]{270, 140});
            add(new float[]{270, 512});
            add(new float[]{337, 507});
            add(new float[]{337, 227});
            add(new float[]{337, 750});
            add(new float[]{714, 750});
            add(new float[]{766, 230});
            add(new float[]{736, 540});
            add(new float[]{878, 521});
            add(new float[]{813, 159});
            add(new float[]{631, 148});
            add(new float[]{623, 0});
        }});
    }
}




class Torso2 extends Boundary {
    public Torso2() {
        super(new ArrayList<>() {{
            add(new float[]{507, 0});
            add(new float[]{459, 162});
            add(new float[]{192, 336});
            add(new float[]{258, 428});
            add(new float[]{364, 393});
            add(new float[]{337, 750});
            add(new float[]{714, 750});//reduced the #of points
            add(new float[]{814, 410});
            add(new float[]{767, 410});
            add(new float[]{568, 232});
            add(new float[]{623, 0});
        }});
    }
}


class Torso3 extends Boundary {
    public Torso3() {
        super(new ArrayList<>() {{
            add(new float[]{623, 0});
            add(new float[]{600, 123});
            add(new float[]{817, 139});
            add(new float[]{846, 12});
            add(new float[]{986, 24});
            add(new float[]{987, 64});
            add(new float[]{891, 66});
            add(new float[]{866, 170});
            add(new float[]{664, 167});
            add(new float[]{750, 485});
            add(new float[]{714, 750});
            add(new float[]{337, 750});
            add(new float[]{450, 263});
            add(new float[]{420, 233});
            add(new float[]{176, 257});
            add(new float[]{152, 208});
            add(new float[]{231, 206});
            add(new float[]{500, 146});
            add(new float[]{507, 0});
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
            add(new float[]{507, 0});
            add(new float[]{623, 0});
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
            add(new float[]{539, 0});

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
            add(new float[]{439, 0});
            add(new float[]{527, 259});
            add(new float[]{436, 694});
            add(new float[]{598, 698});
            add(new float[]{633, 264});
            add(new float[]{539, 0});

            add(new float[]{765, 0});
            add(new float[]{832, 692});
            add(new float[]{990, 683});
            add(new float[]{861, 0});
        }});
    }
}


class Feet3 extends Boundary {
    public Feet3() {
        super(new ArrayList<>() {{
            add(new float[]{439, 0});
            add(new float[]{419, 359});
            add(new float[]{243, 522});
            add(new float[]{198, 480});
            add(new float[]{237, 582});
            add(new float[]{477, 357});
            add(new float[]{539, 0});

            add(new float[]{765, 0});
            add(new float[]{630, 349});
            add(new float[]{788, 557});
            add(new float[]{843, 462});
            add(new float[]{792, 486});
            add(new float[]{686, 337});
            add(new float[]{861, 0});
        }});
    }
}