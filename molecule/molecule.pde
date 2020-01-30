
import controlP5.*;
import processing.opengl.*;

ControlP5 cp5;
Slider ex;

int nAtoms, nBonds, a, b, btype;
atom[] atoms;
bond[] bonds;
float rotx, roty, rotz, zoom, x, y, z, jiggle, glow;
String [] mol;
String path = "DB00693.3dsdf";
color[] c ;
String [] elements;
float [] atomSizes;
String element; 
PImage img;

void setup() {
  size(512, 512, P3D);
  cp5 = new ControlP5(this);
  cp5.addSlider("jiggle")
    .setPosition(10, 10)
    .setRange(0, 4)
    .setHeight(20);
  cp5.addSlider("glow")
    .setPosition(10, 40)
    .setRange(0, 10)
    .setHeight(20);
  cp5.addToggle("toggle")
    .setPosition(250, 10)
    .setSize(50, 20)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setCaptionLabel("model/vanderwaals");
  rotx = roty = rotz=PI/4;
  zoom = 20;
  elements = new String[]{"C", "O", "H"}; 
  atomSizes = new float[]{0.5, 0.5, 0.5}; 
  c = new color[]{color(#404040), color(#800000), color(#A0A0A0)}; 
  mol = loadStrings(path);
  nAtoms = Integer.parseInt(mol[3].split(" ")[1]) ;
  nBonds = Integer.parseInt(mol[3].split(" ")[2]) ;

  atoms = new atom[nAtoms];
  for (int i = 0; i < nAtoms; i++ ) {
    x = Float.parseFloat(mol[i+4].substring (0, 10));
    y = Float.parseFloat(mol[i+4].substring (10, 20));
    z = Float.parseFloat(mol[i+4].substring (20, 30));
    element = mol[i+4].substring (31, 32);
    atoms[i] = new atom(x, y, z, index(elements, element), i);
  }
  bonds = new bond[nBonds];
  for (int i = 0; i < nBonds; i++ ) {
    println(mol[i+4+nAtoms]);
    a = Integer.parseInt(mol[i+4+nAtoms].substring (0, 3).trim());
    b = Integer.parseInt(mol[i+4+nAtoms].substring (3, 6).trim());
    println(mol[i+4+nAtoms].substring (6, 8));
    btype = Integer.parseInt(mol[i+4+nAtoms].substring (6, 9).trim());
    bonds[i] = new bond(a, b, btype);
  }
}
void draw() {
  hint(ENABLE_DEPTH_TEST);
  pushMatrix();
  background(0);
  ambientLight(220, 220, 200);
  directionalLight(255, 255, 255, -1, 1, 0);
  translate (width/2, height/2);
  rotateX(rotx);
  rotateY(roty);
  scale(zoom);
  noStroke();
  if (glow>0) {
    for (int i = 0; i < nAtoms; i++ )
      atoms[i].addGlow(color(#00FF00));
    img = get();
    img.resize(100, 100);
    img.filter(BLUR, glow);
    img.resize(width, height);
    background(64);
    set(0, 0, img);
  }

  for (int i = 0; i < nAtoms; i++ )
    atoms[i].display();
  for (int i = 0; i < nBonds; i++ )
    bonds[i].display();
  popMatrix();
  hint(DISABLE_DEPTH_TEST);
}
void mouseDragged() {
  if (!(cp5.isMouseOver(cp5.getController("jiggle"))||cp5.isMouseOver(cp5.getController("glow"))))
  {
    float rate = 0.01;
    rotx -= (pmouseY-mouseY) * rate;
    roty += (pmouseX-mouseX) * rate;
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom = zoom+0.5*e;
}
int index(String[] arr, String ele) {
  int i = 0;
  while (i < arr.length) {
    if (arr[i].equals(ele)) return i;
    i++;
  }
  return -1;
}

void jiggle(float f) {
  jiggle = f;
}
void glow(float f) {
  glow = f;
}

void toggle(boolean b) {
  if (b!=true) {
    atomSizes = new float[]{1.7, 1.52, 1.2};
  } else {
    atomSizes = new float[]{0.5, 0.5, 0.5};
  }
}
