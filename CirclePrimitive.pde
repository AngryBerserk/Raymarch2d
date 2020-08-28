class CirclePrimitive extends Primitive
{
  private float _w;
  private PVector _pos;
  
  public CirclePrimitive(PVector p0, float w)
  {
    _w = w;
    _pos = p0;
  }
  
  public float Distance(PVector v0)
  {
    return v0.copy().add(camera).dist(_pos.copy()) - _w/2;
  }
  
  public void draw()
  {
     ellipse(_pos.x, _pos.y, _w, _w); 
  }
}
