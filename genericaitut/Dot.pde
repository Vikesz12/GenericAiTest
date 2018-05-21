class Dot{
  PVector pos;
  PVector vel;
  PVector acl;
  Brain brain;
  
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0;
  
  Dot(){
    brain = new Brain(400);
    pos = new PVector(width/2,height - 10);
    vel = new PVector(0,0);
    acl = new PVector(0,0);
  }
  
  void show(){
    if(isBest){
      fill(0,255,0);
      ellipse(pos.x,pos.y,5,5);
    }
    else{
      fill(0);
      ellipse(pos.x,pos.y,3,3);
    }  
  }
  
  void move(){
    if(brain.directions.length > brain.step){
      acl = brain.directions[brain.step];
      brain.step++;
    }
    else{dead = true;}
    vel.add(acl);
    vel.limit(5);
    pos.add(vel);
  }
  
  void update(){
    if(!dead && !reachedGoal){
      move();
      if(pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2){
        dead = true;
      } else if(dist(pos.x, pos.y, goal.x, goal.y) < 3){
        reachedGoal = true;
      } else if (obsticleHit()){
        dead = true;
      }
    }
  }
  
  Boolean obsticleHit(){
    for(Obsticle o:obs){
      if(o.isHit(pos)){
        return true;
      }
  }
    
    return false;
  }
  void calculateFitness(){
    if(reachedGoal){
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {
      float distToGoal = dist(pos.x,pos.y,goal.x,goal.y);
      fitness = 1.0/(distToGoal * distToGoal);
    }
  }
  
  Dot getChild(){
    Dot child = new Dot();
    child.brain = brain.clone();
    return child;
  }
}
