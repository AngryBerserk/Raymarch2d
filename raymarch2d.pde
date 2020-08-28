PVector camera;
ArrayList<Primitive> shapes = new ArrayList<Primitive>();
int maxDistance = 400;
float epsilon = 0.1;
int ellipseWidth = 60;
PVector zeroVector = new PVector(0,0);

void setup(){
  size(800,800);
  camera = new PVector(maxDistance/2,maxDistance/2);
  for (int c = 0; c<10; c++){
    PVector e = new PVector(random(maxDistance), random(maxDistance));
    PVector p0 = new PVector(100,400);
    PVector p1 = new PVector(500,400);
    //shapes.add(new LinePrimitive(p0, p1));
    shapes.add(new CirclePrimitive(e, 60));
  }
}

float distance(PVector v0){
  float min = maxDistance;
  for (Primitive e: shapes){
    float dist = e.Distance(v0);
    if (dist<min) min = dist; //<>//
  }
  return min;
}

float distance2(PVector v0){
  float min = 0;
  for (Primitive e: shapes){
    float dist = e.Distance(v0);// v0.copy().dist(e.copy().sub(camera)) - ellipseWidth/2;
    min += dist;
  }
  return min/shapes.size();
}

PVector marchRay(PVector v0, PVector v1){
  float dist = distance(v0);
  PVector newV0 = v0.copy().add(v1.copy().normalize().mult(dist));
  if (newV0.mag() < maxDistance && dist > epsilon){
    return marchRay(newV0,v1);  
  }
  newV0.limit(maxDistance).add(camera);
  return newV0;
}

void mouseDragged(){
  camera = new PVector(mouseX, mouseY);  
}

void paint(PVector v){
  //point(v.x, v.y);
  line(camera.x, camera.y, v.x, v.y);
}

void rayAll()
{
  for (int x = -maxDistance; x <= maxDistance; x++){
    PVector v = marchRay(zeroVector,new PVector(x, -maxDistance));
    paint(v);
  }
  for (int x = -maxDistance; x <= maxDistance; x++){
    PVector v = marchRay(zeroVector,new PVector(x, maxDistance));
    paint(v);
  }
  for (int y = -maxDistance; y <= maxDistance; y++){
    PVector v = marchRay(zeroVector,new PVector(-maxDistance, y));
    paint(v);
  }
  for (int y = -maxDistance; y <= maxDistance; y++){
    PVector v = marchRay(zeroVector,new PVector(maxDistance, y));
    paint(v);
  }
}

void drawAll()
{
  for (Primitive el: shapes){
    el.draw();  
  }
}

void draw(){
  background(0);
  stroke(255,255,255);
  //PVector v = marchRay(zeroVector,new PVector(0, maxDistance));
  //paint(v);
  rayAll();
  drawAll();
  ellipse(camera.x, camera.y, 15,15);
  //noLoop();
}
