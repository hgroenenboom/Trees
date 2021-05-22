MultiTree tree;

void setup()
{
  size(1920, 1080);
  frameRate(60);
  noCursor();
  
  final int numPixels = 25;
  final int numTrees = (int)(1380 / (float)numPixels);
  
  tree = new MultiTree(numTrees, numPixels, 10);
}

void draw()
{
  // background(255.0f, ALPHA);
  
  tree.draw();
}
