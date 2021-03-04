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
