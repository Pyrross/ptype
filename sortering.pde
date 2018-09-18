void sortering () {
  float[] distances = new float[enemies.size()];
  mindex = 0;

  for (int i = 0; i < enemies.size(); i++)
  {
     distances[i] = enemies.get(i).distance();
  }

  for (int i = 0; i < enemies.size(); i++)
  {
     if ( distances[i] < distances[mindex] )
     {
        mindex = i;
     }
     if ( enemies.get(i).corresponding == true || keyPressed == false ) {
      continueStreak = true;
      keyPressed = false;
    }
  }
  if (continueStreak == false)
    streak = 0;
}

int getIndexOfClosestEnemy () {
   int mindex = 0; // This should be a global variable
   float[] distances = new float[enemies.size()];
   for (int i = 0; i < enemies.size(); i++)
   {
     if (enemies.get(i).corresponding == true)
      distances[i] = enemies.get(i).distance();
   }

   for (int i = 0; i < enemies.size(); i++)
   {
      if (distances[i] < distances[mindex])
      {
         mindex = i;
      }
   }
   return mindex;
}
