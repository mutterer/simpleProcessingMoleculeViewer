int nAtoms;
atom[] atoms;
float rotx, roty, rotz, zoom, x, y, z;
String [] mol;
String path = "DB00693.3dsdf";
color[] c ;
String [] elements;
float [] atomSizes;
String element;
void setup() {
  size(512, 512, P3D);
  rotx = roty = rotz=PI/4;
  zoom = 30;
  elements = new String[]{"C", "O", "H"}; 
  atomSizes = new float[]{0.85, 0.9, 0.25}; 
  c = new color[]{color(#404040), color(#800000), color(#A0A0A0)}; 
  mol = loadStrings(path);
  nAtoms = Integer.parseInt(mol[3].split(" ")[1]) ;
  atoms = new atom[nAtoms];
  for (int i = 0; i < nAtoms; i++ ) {
    x = Float.parseFloat(mol[i+4].substring (0, 10));
    y = Float.parseFloat(mol[i+4].substring (10, 20));
    z = Float.parseFloat(mol[i+4].substring (20, 30));
    element = mol[i+4].substring (31, 32);
    atoms[i] = new atom(x, y, z, atomSizes[index(elements, element)], index(elements, element), i);
  }
}
void draw() {
  background(128);
  ambientLight(220, 220, 200);
  directionalLight(255, 255, 255, -1, 0, 0);
  translate (width/2, height/2);
  rotateX(rotx);
  rotateY(roty);
  scale(zoom);
  noStroke();
  for (int i = 0; i < nAtoms; i++ )
    atoms[i].display();
}
void mouseDragged() {
  float rate = 0.01;
  rotx -= (pmouseY-mouseY) * rate;
  roty += (pmouseX-mouseX) * rate;
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom = zoom+0.5*e;
  println(zoom);
}
int index(String[] arr, String ele) {
  int i = 0;
  while (i < arr.length) {
    if (arr[i].equals(ele)) return i;
    i++;
  }
  return -1;
}
