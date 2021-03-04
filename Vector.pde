
/** 
  Basic vector class for applying simple math/functions to positions and angles. 
*/
class Vector
{ 
  Vector(float x, float y)
  {
    setPosition(x, y);
  }
  
  Vector(float angle)
  {
    changeAngle(angle);
  }
  
  public void changeAngle(float angle)
  {
    this.angle = angle;
    
    final float distance = getDistance();
    x = cos(angle) * distance;
    y = sin(angle) * distance;
  }
  
  public void setPosition(float x, float y)
  {
    this.x = x;
    this.y = y;
    
    angle = atan2(y,  x);
  }
  
  public void moveTo(float angle, float distance)
  {
    setPosition(
      x + cos(angle) * distance,
      y + sin(angle) * distance
    );
  }
  
  public float getDistance()
  {
    return pow(pow(x, 2.0f) + pow(y, 2.0f), 0.5f);
  }
  
  // TODO: should be private, to make sure the angle and x/y state are kept sync
  public float x = 1.0f, y = 0.0f;
  public float angle = 0.0f;
}
