class atom {
  float x, y, z, radius;
  int type, index;
  atom (float x, float y, float z, float radius, int type, int index) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.radius=radius;
    this.type=type;
    this.index=index;
  }
  void display() {
    pushMatrix();
    translate(x+random(1)/20, y+random(1)/20, z+random(1)/20) ;
    fill (c[type]);
    sphere(radius);
    popMatrix();
  }
}
