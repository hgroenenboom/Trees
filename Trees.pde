boolean addingTree = false;
Vector mousePos = new Vector(0,0);
int counter = 0;
int offset = 0;

ArrayList<Tree> trees = new ArrayList<Tree>();

void setup()
{
  size(1920, 1080);
  frameRate(60);
  noCursor();
}

void draw()
{
  //background(255.0f, ALPHA);
  
  // Flag tree to be added if mouse if pressed (once)
  if(!addingTree)
  {
    addingTree = mousePressed;
    mousePos.setPosition(mouseX, mouseY);
    
    counter = 0;
    offset = 0;
  }
  
  final int numTrees = 80;
  final int drift = 40;

  if (addingTree) 
  {
    offset += drift - counter;
    final float randomSeed = 1.0f / numTrees * (float)counter;
    
    trees.add(new Tree((int)mousePos.x + offset, (int)mousePos.y + offset, INIT_SPEED, BRANCH_COUNT, randomSeed));
    counter++;
    
    if(counter == numTrees)
      addingTree = false;
  }
  
  for(Tree tree : trees)
    tree.draw();
}
