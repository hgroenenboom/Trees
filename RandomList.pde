class RandomList
{
  final int SIZE;
  
  int counter = 0;
  float[] randoms;
  
  public RandomList(int seed, int size)
  {
    this.SIZE = size;
    
    // Set seed to fill this random list from
    randomSeed(seed + RANDOM_LIST_SEED);
    
    // Create random values
    randoms = new float[SIZE];
    for(int i = 0; i < SIZE; i++)
    {
      randoms[i] = random(0.0f, 1.0f);
    }
  }
  
  public float get(float min, float max)
  {
    counter = (counter + 1) % SIZE;
    return min + (max - min) * randoms[counter];
  }
}
