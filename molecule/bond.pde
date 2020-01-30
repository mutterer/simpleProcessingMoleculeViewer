class bond {
  int a,b,btype;
  bond (int a, int b, int btype) {
    this.a=a;
    this.b=b;
    this.btype=btype;
  }
  void display() {
    // translate(x, y, z) ;
    stroke(#528153);
    strokeWeight(0.5/btype);
    strokeJoin(ROUND);
    line(atoms[a-1].x,atoms[a-1].y,atoms[a-1].z,atoms[b-1].x,atoms[b-1].y,atoms[b-1].z) ;
  }
}
