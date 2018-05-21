Population test;
PVector goal = new PVector(100,200);
Obsticle[] obs;

void setup(){
  size(1280,720);
  frameRate(120);
  test = new Population(1500);
  obs = new Obsticle[2];
  obs[0] = new Obsticle(0,300,600,10);
  obs[1] = new Obsticle(420,700,420,10);
}

void draw(){
  
  background(255);
  fill(255,0,0);
  ellipse(goal.x,goal.y,5,5);
  
  for(Obsticle o: obs){
    o.draw();
  }
  
  if(test.allDotsDead()){
    test.calcFitness();
    test.naturalSelection();
    test.mutateChild();
  } else {
    test.update();
    test.show();
  }
}
