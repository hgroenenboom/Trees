class MultiTree
{
  // Settings
  public final int numTrees;
  public final int drift;
  public final int randomCount;
  
  // Mouse/UX state
  private boolean addingTree = false;
  private Vector mousePos = new Vector(0,0);
  
  // Algorithm state
  private int counter = 0;
  private int offset = 0;

  ArrayList<MorphingTree> trees = new ArrayList<MorphingTree>();

  public MultiTree(int numTrees, int positionDrift, int randomArraySize)
  {
    this.numTrees = numTrees;
    this.drift = positionDrift;
    this.randomCount = randomArraySize;
  }

  public void draw()
  {
    // Flag tree to be added if mouse if pressed (once)
    if(!addingTree)
    {
      addingTree = mousePressed;
      mousePos.setPosition(mouseX, mouseY);
      
      // Reset state
      counter = 0;
      offset = 0;
    }
  
    if (addingTree) 
    {
      // Calculate position offset and random seed to pass to new tree object
      offset += drift;
      // offset += drift - counter;
      final float randomSeed = 1.0f / numTrees * (float)counter;
      
      // Add new tree object
      trees.add(new MorphingTree(
          (int)mousePos.x + offset, 
          (int)mousePos.y + offset, 
          INIT_SPEED, 
          BRANCH_COUNT, 
          randomSeed, 
          randomCount)
      );
      
      // Increment counter and disable adding of trees if given amount of trees is reached
      counter++;
      if(counter == numTrees)
        addingTree = false;
    }
    
    for(MorphingTree tree : trees)
      tree.draw();
  }
  
};
