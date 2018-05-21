class Obsticle{
  PVector pos1;
  PVector size;
  
  Obsticle(int x1, int y1,int x2, int y2){
    pos1 = new PVector(x1,y1);
    size = new PVector(x2,y2);
  }
  
  
  void draw(){
    fill(0,0,255);
    rect(pos1.x,pos1.y,size.x,size.y);
  }
  
  Boolean isHit(PVector pos){
   return (pos.x < (pos1.x+size.x) && pos.y < (pos1.y + size.y) && pos.x > pos1.x && pos.y > pos1.y);
  }
}
