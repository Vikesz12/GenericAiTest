class Population{
  Dot dots[];
  
  float fitnessSum;
  int gen = 1;
  
  int bestDot = 0;
  
  int minStep = 1000;
  
  Population(int size){
    dots = new Dot[size];
    for(int i = 0; i < size;++i){
      dots[i] = new Dot();
    }
  }
  
  void show(){
     for (int i = 1; i< dots.length; ++i) {
      dots[i].show();
    }
    
    dots[0].show();
  }
  
  void update(){
    for(Dot d: dots){
      if(d.brain.step > minStep){
        d.dead = true;
      } else {
        d.update();
      }
    }
  }
  
  void calcFitness(){
    for(Dot d: dots){
      d.calculateFitness();
    }
  }
  
  Boolean allDotsDead(){
    for(Dot d: dots){
      if(!d.dead && !d.reachedGoal){
        return false;
      }
    }
    
    return true;
  }
  
  void calcFitnessSum(){
    fitnessSum = 0;
    for(Dot d: dots){
      fitnessSum += d.fitness;
    }
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum);
    
    float runningSum = 0;
    
    for(Dot d : dots){
      runningSum+= d.fitness;
      if(runningSum > rand){
        return d;
      }
    }
    
    return null;
  }
  
  void mutateChild(){
    for (int i = 1; i< dots.length; ++i) {
      dots[i].brain.mutate();
    }
  }
  
  void setBestDot(){
    float max = 0;
    int maxIndex = 0;
    for(int i = 0 ; i< dots.length;++i){
      if(dots[i].fitness > max){
          max = dots[i].fitness;
          maxIndex = i;
      }
    }
    
    bestDot = maxIndex;
    
    if(dots[bestDot].reachedGoal){
      minStep = dots[bestDot].brain.step;
      println("step:",minStep);
      println("pop:",dots.length);
    }
  }
  void naturalSelection(){
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calcFitnessSum();
    
    newDots[0] = dots[bestDot].getChild();
    newDots[0].isBest = true;
    for (int i = 1; i< dots.length; ++i) {
      Dot parent = selectParent();
      
      newDots[i] = parent.getChild();
    }
    
    dots = newDots.clone();
    gen++;
    println("gen:",gen);
  }
}
