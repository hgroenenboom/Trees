final float TWOPI = 6.32f; 

// ALL THESE PARAMETERS SHOULD BECOME ACCESIBLE VIA AN INTERFACE (WITH SLIDERS OR SOMEHTING):

final float BRANCH_ANGLE_OFFSET = 0.1f; // DEF: 1
final float BRANCHING_CHANCE = 7.0f / 100.0f; // DEF: 0.02 (2%)
final float BRANCH_MOVEMENT = 0.4f; // DEF: 0.2
final int BRANCH_COUNT = 6; // DEF: 3
final float WIDTH_EXPANSION = 1.0f + 1.0f; // DEF: 1.0f;
final float WIDTH_MULTIPLIER = 0.05f; // DEF: 1.0f;
final int BRANCH_COUNT_REDUCTION = 2; // DEF: 1
final float ALPHA = 0.0f;

final float INIT_SPEED = 20.0f; // DEF: 5
final float MINSPEED = 0.1f; // DEF: 0.1
final float SPEED_MULTIPLIER = 0.96; // DEF: 1
final float SPEED_INCREMENT = -0.0; // DEF: -0.1
final float SPEED_RANDOM_DEV = 0.0f; // DEF: 0.05

class Vector
{
  public float x = 1.0f, y = 0.0f;
  public float angle = 0.0f;
  
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
}



class Tree
{
  Tree(int x, int y, float speedInPixels, int numLines)
  {
    this.numLines = numLines;
    this.speed = speedInPixels;
    
    directions = new Vector[numLines];
    positions = new Vector[numLines];
    trees = new Tree[numLines];
    
    for(int i = 0; i < numLines; i++)
    {
      // Create random directions
      directions[i] = new Vector(- random(0.0f, TWO_PI));
      
      // Set inital line positions on centre point
      positions[i] = new Vector(x, y);
    }
  }
  
  void draw()
  {
    if(speed <= MINSPEED)
      return;
    
    for(int i = 0; i < numLines; i++)
      if(trees[i] != null)
        trees[i].draw();
    
    for(int i = 0; i < numLines; i++)
    {
      if(trees[i] != null)
        continue;
      
      final float oldX = positions[i].x;
      final float oldY = positions[i].y;
      
      positions[i].moveTo(directions[i].angle, speed);
      strokeWeight(pow(WIDTH_MULTIPLIER * speed, WIDTH_EXPANSION));
      line(oldX, oldY, positions[i].x, positions[i].y);
      
      directions[i].angle += random( - BRANCH_MOVEMENT, BRANCH_MOVEMENT );
      
      if(random(0.0f, 1.0f) < BRANCHING_CHANCE)
      {
        final int newNumLines = max(numLines - BRANCH_COUNT_REDUCTION, 0);
        
        trees[i] = new Tree((int)positions[i].x, (int)positions[i].y, speed, newNumLines );  
        
        for(int j = 0; j < newNumLines; j++)
        {
          // Apply new branch angle offset
          trees[i].directions[j].changeAngle(directions[i].angle + random(-BRANCH_ANGLE_OFFSET, BRANCH_ANGLE_OFFSET));
        }
      }
    }
    
    speed += random(SPEED_INCREMENT - SPEED_RANDOM_DEV, SPEED_INCREMENT + SPEED_RANDOM_DEV);
    speed *= SPEED_MULTIPLIER;
  }
  
  private float speed;
  private final int numLines;
  
  // Directions and line positions for this tree
  private Vector[] directions;
  private Vector[] positions;
  
  private Tree[] trees; 
}

ArrayList<Tree> trees = new ArrayList<Tree>();

void setup()
{
  size(1920, 1080);
  frameRate(60);
}

void draw()
{
  //background(255.0f, ALPHA);
  
  if (mousePressed == true) 
    trees.add(new Tree(mouseX, mouseY, INIT_SPEED, BRANCH_COUNT));
  
  for(Tree tree : trees)
    tree.draw();
}
