
class Tree
{
  /** A Tree origin of which branches are drawn. A Tree can contain multiple Tree's which are essentially subbranches.
    * The draw call recursively calls all the subtrees to also draw when necessary.
    *  
    * @param x                The x origin position of the Tree
    * @param y                The y origin position of the Tree
    * @param speedInPixels    The starting drawing speed (in pixesl) of the Tree
    * @param numLines         The amount of lines/branches to spawn of the origin point
  */
  Tree(int x, int y, float speedInPixels, int numLines)
  {
    // Init variables
    this.numLines = numLines;
    this.speed = speedInPixels;
    
    // Initialize data structures
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
    // 1. Low speed disabled drawing
    if(speed <= MINSPEED)
      return;
    
    // 2. Draw the branches if they exist (recursively)
    for(int i = 0; i < numLines; i++)
      if(trees[i] != null)
        trees[i].draw();
    
    // 3. main draw loop (through branches)
    for(int i = 0; i < numLines; i++)
    {
      if(trees[i] != null)
        continue;
      
      // i. Get current position of branch
      final float oldX = positions[i].x;
      final float oldY = positions[i].y;
      
      // ii. Move current position along the current direction
      positions[i].moveTo(directions[i].angle, speed);
      
      // iii. Draw line between old and new position
      strokeWeight(pow(WIDTH_MULTIPLIER * speed, WIDTH_EXPANSION));
      line(oldX, oldY, positions[i].x, positions[i].y);
      
      // iv. Add variation to the target angle of the branch
      directions[i].angle += random( - BRANCH_MOVEMENT, BRANCH_MOVEMENT );
      
      // v. Let chance decide whether whether this branch branches into new branches
      if(random(0.0f, 1.0f) < BRANCHING_CHANCE)
      {
        final int newNumLines = max(numLines - BRANCH_COUNT_REDUCTION, 0);
       
        // Create a new branch (Tree)
        trees[i] = new Tree((int)positions[i].x, (int)positions[i].y, speed, newNumLines );  
        
        // Generate new angle for each branch
        for(int j = 0; j < newNumLines; j++)
          trees[i].directions[j].changeAngle(directions[i].angle + random(-BRANCH_ANGLE_OFFSET, BRANCH_ANGLE_OFFSET));
      }
    }
    
    // Adjust speed (usually decrease, otherwise the branch will forever keep drawing, and a branch should eventually stop growing is the idea)
    speed += random(SPEED_INCREMENT - SPEED_RANDOM_DEV, SPEED_INCREMENT + SPEED_RANDOM_DEV);
    speed *= SPEED_MULTIPLIER;
  }
  
  // The speed in pixels at which this tree is drawn
  private float speed;
  
  // Amount of branches to draw
  private final int numLines;
  
  // Directions (angles) and line positions for this tree
  private Vector[] directions;
  private Vector[] positions;
  
  // Sub trees for this tree segment
  private Tree[] trees; 
}
