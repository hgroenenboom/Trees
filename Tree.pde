
class MorphingTree
{
  /** A Tree origin of which branches are drawn. A Tree can contain multiple Tree's which are essentially subbranches.
    * The draw call recursively calls all the subtrees to also draw when necessary.
    *  
    * @param x                The x origin position of the Tree
    * @param y                The y origin position of the Tree
    * @param speedInPixels    The starting drawing speed (in pixesl) of the Tree
    * @param numLines         The amount of lines/branches to spawn of the origin point
  */
  MorphingTree(int x, int y, float speedInPixels, int numLines, float crossFade, int randomSize)
  {
    // Init variables
    this.numLines = numLines;
    this.speed = speedInPixels;
    this.crossFade = crossFade;
    
    // Create two random lists with custom seeds
    this.randomArraySize = randomSize;
    randomLists = new RandomList[2];
    randomLists[0] = new RandomList(0, randomArraySize);
    randomLists[1] = new RandomList(1, randomArraySize);
    
    // Initialize data structures
    directions = new Vector[numLines];
    positions = new Vector[numLines];
    trees = new MorphingTree[numLines];
    
    for(int i = 0; i < numLines; i++)
    {
      // Create random directions
      directions[i] = new Vector(- randomOfTwo(0.0f, TWO_PI, crossFade));
      
      // Set inital line positions on centre point
      positions[i] = new Vector(x, y);
    }
  }
  
  void draw()
  {    
    // 1. Low speed disabled drawing
    if(speed <= MINSPEED || branches >= BRANCH_MAXIMUM_COUNT)
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
      directions[i].angle += randomOfTwo( - BRANCH_MOVEMENT, BRANCH_MOVEMENT, crossFade );
      
      // v. Let chance decide whether whether this branch branches into new branches
      if(randomOfTwo(0.0f, 1.0f, crossFade) < BRANCHING_CHANCE)
      {
        final int newNumLines = max(numLines - BRANCH_COUNT_REDUCTION, 0);
       
        // Create a new branch (Tree)
        trees[i] = new MorphingTree((int)positions[i].x, (int)positions[i].y, speed, newNumLines, crossFade, randomArraySize ); 
        trees[i].topLevelTree = topLevelTree;
        topLevelTree.branches += newNumLines;
        
        // Generate new angle for each branch
        for(int j = 0; j < newNumLines; j++)
          trees[i].directions[j].changeAngle(directions[i].angle + randomOfTwo(-BRANCH_ANGLE_OFFSET, BRANCH_ANGLE_OFFSET, crossFade));
      }
    }
    
    // Adjust speed (usually decrease, otherwise the branch will forever keep drawing, and a branch should eventually stop growing is the idea)
    speed += randomOfTwo(SPEED_INCREMENT - SPEED_RANDOM_DEV, SPEED_INCREMENT + SPEED_RANDOM_DEV, crossFade);
    speed *= SPEED_MULTIPLIER;
  }
  
  float randomOfTwo(float min, float max, float crossfade)
  {
     return (1.0f - crossfade) * randomLists[0].get(min, max) + crossfade * randomLists[1].get(min, max);
  }
  
  // The speed in pixels at which this tree is drawn
  private float speed;
  
  private MorphingTree topLevelTree = this;
  private int branches = 0;
  
  // Amount of branches to draw
  private final int numLines;
  
  /** Crossfade amount between the two randoms, can be used in combination with a random seed to create similar copies of a single tree */
  RandomList[] randomLists;
  public final int randomArraySize;
  private final float crossFade;
  
  // Directions (angles) and line positions for this tree
  private Vector[] directions;
  private Vector[] positions;
  
  // Sub trees for this tree segment
  private MorphingTree[] trees; 
}
