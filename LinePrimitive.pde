class LinePrimitive extends Primitive
{
  private PVector _pos0;
  private PVector _pos1;
  private float _y2my1;
  private float _x2mx1;
  private float _x2y1;
  private float _d;
  private float x1;
  private float x2;
  private float y1;
  private float y2;
  
  public LinePrimitive(PVector p0, PVector p1)
  {
    _pos0 = p0;
    _pos1 = p1;
    _y2my1 = p1.y - p0.y;
    _x2mx1 = p1.x - p0.x;
    _x2y1 = (p1.x * p0.y) - (p1.y * p0.x);
    _d = sqrt(sq(p1.y - p0.y) + sq(p1.x - p0.x));
    x1 = _pos0.x;
    x2 = _pos1.x;
    y1 = _pos0.y;
    y2 = _pos1.y;
  }
  
  public float Distance(PVector v0)
  {
    PVector v = PVector.add(v0, camera);
    float dist = Math.abs(_y2my1*v.x - _x2mx1*v.y + _x2y1)/_d;
    if (abs(dist) < 0.0001)
      return 0;
    PVector v1 = v.copy().mult(dist);
    float x3 = v.x;
    float x4 = v1.x;
    
    float y3 = v.y;
    float y4 = v1.y;
    
    float d = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
    if (abs(d) < 0.0001) //<>//
      return maxDistance;
    float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/d;
    float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/d;
    if (t>0 && t<1 && u > 0)
      {
        //println(dist);
        return dist;
      }
    return maxDistance;
  }
  
  public void draw()
  {
    line(_pos0.x, _pos0.y, _pos1.x, _pos0.y);
  }
}
