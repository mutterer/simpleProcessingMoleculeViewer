class atom {
  float x, y, z, radius;
  int type, index;
  atom (float x, float y, float z, int type, int index) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.type=type;
    this.index=index;
  }
  void display() {
    pushMatrix();
    // translate(x, y, z) ;
    translate(x+jiggle*random(1)/20, y+jiggle*random(1)/20, z+jiggle*random(1)/20) ;
    fill (c[type]);
    radius = atomSizes[type];
    sphere(radius);
    popMatrix();
  }
  void addGlow(color col) {
    pushMatrix();
    translate(x, y, z) ;
    fill (col);
    sphere(radius);
    popMatrix();
  }
}
